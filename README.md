# fishtech

project to help fish farmer with managing their water and autofeeder.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# Test Documentation

## Register Tests (`register_test.dart`)

### Form Field Validation Tests
1. **Required Fields Check**
    - Verifies presence of all form fields (Name, Email, Password, Confirm Password)
    - Checks visibility of Register and Google Sign-in buttons

2. **Empty Form Submission**
    - Tests error messages for empty form submission
    - Validates error messages for all required fields

3. **Email Format Validation**
    - Tests invalid email format detection
    - Verifies appropriate error message display

4. **Password Validation**
    - Tests password matching functionality
    - Validates minimum password length requirement (6 characters)
    - Shows appropriate error messages for mismatched passwords

### Registration Process Tests
1. **Successful Registration**
    - Validates form submission with valid data
    - Verifies correct call to signUpWithEmail
    - Tests proper parameter passing

2. **Loading State**
    - Verifies loading indicator during registration
    - Tests proper loading state management
    - Confirms loading indicator removal after completion

### Navigation Tests
- Tests navigation to login screen
- Verifies proper routing after successful registration

## Logout Tests (`logout_test.dart`)

### Authentication State Tests
1. **UI Element Verification**
    - Tests logout button visibility in authenticated state
    - Verifies presence of CustomButton widget
    - Validates email field read-only state

2. **Logout Functionality**
    - Tests successful logout process
    - Verifies proper call to signOut method
    - Validates error handling during logout failure

3. **Error Handling**
    - Tests error message display on logout failure
    - Verifies SnackBar appearance with correct error message

## Profile Data Tests (`profileData_test.dart`)

### Session Data Tests
1. **User Data Retrieval**
    - Verifies correct user data extraction from session
    - Tests email address retrieval
    - Validates user metadata handling (name, picture)

2. **Metadata Handling**
    - Tests handling of null metadata
    - Verifies proper fallback behavior
    - Validates metadata field access

### Session Management
- Verifies proper session state handling
- Tests authentication state changes
- Validates session data persistence

## FCM Update Tests (`updateFCM_test.dart`)

### Token Management Tests
1. **Token Update Logic**
    - Tests token comparison between new and stored tokens
    - Verifies update process for different tokens
    - Validates no update for identical tokens

2. **Authentication State Handling**
    - Tests token updates in authenticated state
    - Verifies no updates in unauthenticated state
    - Validates proper state transitions

### Storage and Integration Tests
1. **SharedPreferences Integration**
    - Tests token storage in SharedPreferences
    - Verifies proper token retrieval
    - Validates token update persistence

2. **Firebase Messaging Integration**
    - Tests FCM token acquisition
    - Verifies proper token format
    - Validates token refresh handling

### Error Handling
1. **Update Failure Handling**
    - Tests error scenarios during token updates
    - Verifies proper error state emissions
    - Validates error message handling

2. **State Management**
    - Tests loading states during updates
    - Verifies proper state transitions
    - Validates completion states