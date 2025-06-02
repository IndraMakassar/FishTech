import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
const SYSTEM_USER_ID = 'system'

// Updated interfaces to match your table structure
interface Sensor {
  id: string
  created_at: string
  name: string
  status: string
  pond_id: string
  type: string
}

interface SensorData {
  id: string
  created_at: string
  reading: number
  sensor_id: string
}

interface Pond {
  id: string
  created_at: string
  name: string
  volume: number
  user_id: string
  fish: string
  fish_amount: number
}

interface WebhookPayload {
  type: 'INSERT' | 'UPDATE'
  table: string
  record: SensorData
  schema: 'public'
  old_record?: SensorData
}

if (!SUPABASE_URL || !SUPABASE_SERVICE_ROLE_KEY) {
  throw new Error('Required environment variables are not set')
}

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY)

const THRESHOLDS = {
  pH: { min: 6.5, max: 8.5 },
  temperature: { min: 25.0, max: 32.0 },
  maxReadingAge: 30, // Increased to 30 minutes
  staleSensorThreshold: 3 // Number of consecutive stale readings before notification
}

// Add function to check sensor's last readings
async function checkSensorHistory(sensorId: string, minutes: number) {
  const timeThreshold = new Date(Date.now() - minutes * 60 * 1000).toISOString();

  const { data, error } = await supabase
    .from('data_sensor')
    .select('created_at')
    .eq('sensor_id', sensorId)
    .gte('created_at', timeThreshold)
    .order('created_at', { ascending: false })
    .limit(1);

  if (error) {
    console.error('Error checking sensor history:', error);
    return false;
  }

  return data && data.length > 0;
}

async function createNotification({
  pond_id,
  title,
  body,
}: {
  pond_id: string,
  title: string,
  body: string,
}) {
  // Get both the pond name and user_id
  const { data: pond, error: pondError } = await supabase
    .from('ponds')
    .select('user_id, name')
    .eq('id', pond_id)
    .single()

  if (pondError || !pond) {
    console.error('Error fetching pond details:', pondError)
    pond = { user_id: SYSTEM_USER_ID, name: 'Unknown Pond' }
  }

  const { error } = await supabase
    .from('notifications')
    .insert([{
      user_id: pond.user_id,
      title,
      body,
      status: 'unread'  // Add this line to set default status
    }])

  if (error) {
    console.error('Error creating notification:', error)
    throw error
  }
}

serve(async (req: Request) => {
  try {
    if (req.method !== 'POST') {
      return new Response(JSON.stringify({ error: 'Only POST requests are accepted' }), {
        status: 405,
        headers: { 'Content-Type': 'application/json', 'Allow': 'POST' }
      })
    }

    const payload: WebhookPayload = await req.json()
    console.log('Received webhook payload:', payload)

    if (payload.table !== 'data_sensor') {
      return new Response(JSON.stringify({ error: 'Invalid table' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' }
      })
    }

    if (!['INSERT', 'UPDATE'].includes(payload.type)) {
      return new Response(JSON.stringify({ error: 'Invalid webhook type' }), {
        status: 400,
        headers: { 'Content-Type': 'application/json' }
      })
    }

    // Get both sensor and pond data
    const { data: sensor, error: sensorError } = await supabase
      .from('sensor')
      .select(`
      id,
      name,
      status,
      pond_id,
      type,
      ponds!inner (
        name
      )
    `)
      .eq('id', payload.record.sensor_id)
      .single()

    if (sensorError) {
      console.error('Error fetching sensor:', sensorError)
      throw new Error(`Failed to fetch sensor details: ${sensorError.message}`)
    }

    if (!sensor) {
      console.error('No sensor found with ID:', payload.record.sensor_id)
      throw new Error(`No sensor found with ID: ${payload.record.sensor_id}`)
    }

    // Process the reading
    const reading = payload.record.reading
    const sensorType = sensor.type.toLowerCase()
    const validation = {
      pond_id: sensor.pond_id,
      sensor_id: sensor.id,
      sensor_name: sensor.name,
      type: sensorType,
      reading,
      isValid: true,
      issues: [],
      age_minutes: Math.floor((Date.now() - new Date(payload.record.created_at).getTime()) / (1000 * 60))
    }

    // Validate reading based on sensor type
    if (sensorType === 'ph') {
      if (reading < THRESHOLDS.pH.min || reading > THRESHOLDS.pH.max) {
        validation.issues.push(`pH level out of range: ${reading}`)
        validation.isValid = false
        await createNotification({
          pond_id: sensor.pond_id,
          title: `pH Alert - ${sensor.ponds.name}`,
          body: `Pond ${sensor.ponds.name}: pH level out of range (${reading}). Normal range is ${THRESHOLDS.pH.min}-${THRESHOLDS.pH.max}`
        })
      }
    }
    else if (sensorType === 'temperature') {
      if (reading < THRESHOLDS.temperature.min || reading > THRESHOLDS.temperature.max) {
        validation.issues.push(`Temperature out of range: ${reading}°C`)
        validation.isValid = false
        await createNotification({
          pond_id: sensor.pond_id,
          title: `Temperature Alert - ${sensor.ponds.name}`,
          body: `Pond ${sensor.ponds.name}: Temperature out of range (${reading}°C). Normal range is ${THRESHOLDS.temperature.min}-${THRESHOLDS.temperature.max}°C`
        })
      }
    }

    // Improved stale sensor detection
    if (validation.age_minutes > THRESHOLDS.maxReadingAge) {
      // Check if there were any readings in the last period
      const hasRecentReadings = await checkSensorHistory(sensor.id, THRESHOLDS.maxReadingAge);

      if (!hasRecentReadings) {
        validation.issues.push(`Sensor inactive for ${validation.age_minutes} minutes`)
        validation.isValid = false

        await createNotification({
          pond_id: sensor.pond_id,
          title: `Sensor Maintenance Required - ${sensor.ponds.name}`,
          body: `${sensorType.toUpperCase()} sensor in ${sensor.ponds.name} hasn't reported for ${validation.age_minutes} minutes.`
        })
      }
    }

    return new Response(JSON.stringify({
      status: 'success',
      result: validation
    }), {
      headers: { 'Content-Type': 'application/json' },
      status: 200,
    })

  } catch (error) {
    console.error('Error:', error)
    return new Response(JSON.stringify({
      status: 'error',
      error: 'Internal server error',
      details: error.message
    }), {
      headers: { 'Content-Type': 'application/json' },
      status: 500,
    })
  }
})