import 'package:get/get.dart';

class Languages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'greeting': 'Hello',
          'enter_valid_email': 'Please enter a valid email address!',
          'email': 'Email',
          'password': 'Password',
          'not_valid_password': 'Password must be at least 7 characters long!',
          'check_logout': 'Are you sure you want to log out?',
          'error': 'An error occured!',
          'user_not_exists': 'User Not Found',
          'wrong_password': 'Wrong Password',
          'process_failed': 'Failed to process',
        },
        'ge_GE': {
          'greeting': 'Hallo',
          'enter_valid_email':
              'Bitte geben Sie eine gültige E-Mail-Adresse ein!',
          'email': 'Email',
          'password': 'Passwort',
          'not_valid_password':
              'Das Passwort muss mindestens 7 Zeichen lang sein!',
          'check_logout': 'Sind Sie sicher, dass Sie sich abmelden möchten?',
          'error': 'Es ist ein Fehler aufgetreten!',
          'user_not_exists': 'Nutzer nicht gefunden',
          'wrong_password': 'Falsches Passwort',
          'process_failed': 'Bearbeitung fehlgeschlagen',
        }
      };
}
