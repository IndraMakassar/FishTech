import { createClient } from "npm:@supabase/supabase-js@2"
import { JWT } from "npm:google-auth-library@9"
import serviceAccount from '../service-account.json' with { type: 'json' }
import { SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY } from '../.env.ts'

interface Notification {
  id: string
  user_id: string
  title: string
  body: string
}

interface WebhookPayload {
  type: 'INSERT'
  table: string
  record: Notification
  schema: 'public'
}

// Replace the createClient call with:
const supabase = createClient(
    SUPABASE_URL,
    SUPABASE_SERVICE_ROLE_KEY
)

async function getAccessToken({
  clientEmail,
  privateKey,
}: {
  clientEmail: string;
  privateKey: string;
}): Promise<string> {
  const jwt = new JWT({
    email: clientEmail,
    key: privateKey,
    scopes: ['https://www.googleapis.com/auth/firebase.messaging'],
  });
  const accessToken = await jwt.getAccessToken();
  return accessToken.token || '';
}

Deno.serve(async (req) => {
  try {
    if (req.method !== 'POST') {
      return new Response('Method not allowed', { status: 405 });
    }

    if (!req.headers.get('content-type')?.includes('application/json')) {
      return new Response('Content-Type must be application/json', { status: 400 });
    }

    const payload: WebhookPayload = await req.json();
    console.log('Received payload:', payload);

    console.log('Checking user:', payload.record.user_id);
    const { data, error } = await supabase
      .from('profiles')
      .select('fcm_token')  // Changed to select all fields to see what's available
      .eq('id', payload.record.user_id)
      .single();

    console.log('Profile data:', data);
    console.log('Profile error:', error);

    if (!data || !data.fcm_token) {
      return new Response(JSON.stringify({
        error: 'User not found or FCM token not set',
        data: data
      }), {
        status: 404,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    const fcmToken = data.fcm_token as string;

    const accessToken = await getAccessToken({
      clientEmail: serviceAccount.client_email,
      privateKey: serviceAccount.private_key,
    });

    const res = await fetch(
      `https://fcm.googleapis.com/v1/projects/${serviceAccount.project_id}/messages:send`,
      {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          Authorization: `Bearer ${accessToken}`,
        },
        body: JSON.stringify({
          message: {
            token: fcmToken,
            notification: {
              title: payload.record.title,
              body: payload.record.body,
            },
          },
        }),
      }
    );

    // Add these debug logs
    console.log('FCM Response status:', res.status);
    const resData = await res.json();
    console.log('FCM Response data:', resData);
    if (res.status < 200 || 299 < res.status) {
      return new Response(JSON.stringify(resData), {
        status: res.status,
        headers: { 'Content-Type': 'application/json' }
      });
    }

    return new Response(JSON.stringify(resData), {
      headers: { 'Content-Type': 'application/json' },
    });

  } catch (error) {
    console.error('Error:', error);
    return new Response(JSON.stringify({ error: error.message }), {
      status: 500,
      headers: { 'Content-Type': 'application/json' }
    });
  }
});