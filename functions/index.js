const { onDocumentCreated } = require("firebase-functions/v2/firestore");
const { initializeApp } = require("firebase-admin/app");
const { getFirestore } = require("firebase-admin/firestore");
const { getMessaging } = require("firebase-admin/messaging");

initializeApp();

/**
 * Triggered when a new notification document is created.
 * Reads the receiver's FCM token and sends a push notification.
 */
exports.onNotificationCreated = onDocumentCreated(
  "notifications/{notificationId}",
  async (event) => {
    const data = event.data?.data();
    if (!data) return;

    const { title, body, receiver, type } = data;
    if (!receiver || !title || !body) return;

    try {
      const db = getFirestore();
      const receiverDoc = await db
        .collection("users")
        .doc(receiver.id)
        .get();

      if (!receiverDoc.exists) return;

      const fcmToken = receiverDoc.data()?.fcm_token;
      if (!fcmToken) return;

      const message = {
        token: fcmToken,
        notification: { title, body },
        data: {
          type: type || "general",
          notificationId: event.params.notificationId,
        },
        apns: {
          payload: {
            aps: { badge: 1, sound: "default" },
          },
        },
        android: {
          priority: "high",
          notification: { sound: "default" },
        },
      };

      await getMessaging().send(message);
      console.log(`Push sent to ${receiver.id} for ${type}`);
    } catch (error) {
      console.error("Error sending push notification:", error);
    }
  }
);
