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
- Test structure prepared for future implementation

## FCM Update Tests (`updateFCM_test.dart`)
- Test structure prepared for future implementation