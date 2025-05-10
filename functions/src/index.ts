import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

admin.initializeApp();

export const sendToTopic = functions.https.onRequest(async (req, res) => {
  if (req.method !== 'POST') {
    res.status(405).send('Method Not Allowed');
    return;
  }

  const { topic, title, body } = req.body;

  if (!topic || !title || !body) {
    res.status(400).send('Missing fields');
    return;
  }

  const message = {
    notification: { title, body },
    topic,
  };

  try {
    const response = await admin.messaging().send(message);
    res.status(200).json({ success: true, messageId: response });
  } catch (error) {
    console.error('Error al enviar mensaje:', error);
    res.status(500).send('Error al enviar mensaje');
  }
});