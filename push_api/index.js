// By Topic for send notification on targeted device


// import { initializeApp, applicationDefault } from "firebase-admin/app";
// import { getMessaging } from "firebase-admin/messaging";
// import express from "express";
// import cors from "cors";

// const app = express();
// app.use(express.json());

// app.use(
//   cors({
//     origin: "*",
//   })
// );

// app.use(
//   cors({
//     methods: ["GET", "POST", "DELETE", "UPDATE", "PUT", "PATCH"],
//   })
// );

// app.use(function (req, res, next) {
//   res.setHeader("Content-Type", "application/json");
//   next();
// });

// initializeApp({
//   credential: applicationDefault(),
//   projectId: "push-notification-6c99f",
// });

// app.post("/send", function (req, res) {
//   const { token, notification } = req.body; // Extract token and notification data from request body

//   if (!token || !notification || !notification.title || !notification.body) {
//     return res.status(400).json({ error: "Token, title, and body are required" });
//   }

//   const message = {
//     notification: {
//       title: notification.title, // Dynamic title from request body
//       body: notification.body,   // Dynamic body from request body
//     },
//     token: token, // Dynamic token from request body
//   };

//   getMessaging()
//     .send(message)
//     .then((response) => {
//       res.status(200).json({
//         message: "Successfully sent message",
//         token: token,
//       });
//       console.log("Successfully sent message: ", response);
//     })
//     .catch((error) => {
//       res.status(400).json({ error: error.message });
//       console.log("Error sending message: ", error);
//     });
// });

// app.listen(3000, function () {
//   console.log("Server started on port 3000");
// });













// By Topic for send notification on multiple device

import { initializeApp, applicationDefault } from "firebase-admin/app";
import { getMessaging } from "firebase-admin/messaging";
import express from "express";
import cors from "cors";

const app = express();
app.use(express.json());

app.use(
  cors({
    origin: "*",
  })
);

app.use(function (req, res, next) {
  res.setHeader("Content-Type", "application/json");
  next();
});

initializeApp({
  credential: applicationDefault(),
  projectId: "push-notification-6c99f",
});

app.post("/send", function (req, res) {
  const { topic, notification } = req.body; // Extract topic and notification data from request body

  if (!topic || !notification || !notification.title || !notification.body) {
    return res.status(400).json({ error: "Topic, title, and body are required" });
  }

  const message = {
    notification: {
      title: notification.title, // Dynamic title from request body
      body: notification.body,   // Dynamic body from request body
    },
    topic: topic, // Use the topic from request body
  };

  getMessaging()
    .send(message)
    .then((response) => {
      res.status(200).json({
        message: "Successfully sent message to topic",
        topic: topic,
      });
      console.log("Successfully sent message: ", response);
    })
    .catch((error) => {
      res.status(400).json({ error: error.message });
      console.log("Error sending message: ", error);
    });
});

app.listen(3000, function () {
  console.log("Server started on port 3000");
});
