# Marketing Expense Prediction App
This is a Flutter-based application that allows users to predict TV sales based on their marketing expenses

## Features
- User interface for entering marketing expenses.
- Integration with a backend API (FastAPI) to perform the sales prediction.
- Display of the predicted sales based on the user's input.
- Error handling and display of error messages.

# Prerequisites
- Flutter SDK 2.0.0 or higher
- Dart 2.12.0 or higher
- A running FastAPI backend server (see the FastAPI backend README)

# Installation
1. Clone the repository:
```
git clone https://github.com/JoakBouy/flutter-tv_sales.git
```
2. Install required dependencies
```
flutter pub get
```

# Running the app
1. Ensure that the FastAPI backend server is running at http://127.0.0.1:8000.
2. Start the Flutter app:
```
flutter run
```
The app will start running on your connected device or emulator.

# Usage
1. Open the app on your device or emulator.
2. Enter the marketing expenses in the text field.
3. Click the "Predict" button.
4. The app will display the predicted TV sales based on the provided marketing expenses.

# Error Handling
If there are any issues with the prediction (e.g., the backend server is not running, or the input data is invalid), the app will display a Snackbar with the error message.

# Future Improvements
- Implement more robust error handling and feedback mechanisms.
- Add the ability to save and view historical prediction data.
- Enhance the user interface with better design and animations.
- Implement unit tests and integration tests.
- Explore the possibility of deploying the app to app stores.
