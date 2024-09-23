// const admin = require('firebase-admin');
import admin from "firebase-admin";
const serviceAccount = require('./service-account.json');

// Initialize Firebase Admin SDK
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://push-notification-6c99f-default-rtdb.firebaseio.com/"  
});

module.exports = admin;




// $env:GOOGLE_APPLICATION_CREDENTIALS="D:\OneDrive - Cenergist\Apps\Flutter\push_notify_api\push_api\service-account.json"
