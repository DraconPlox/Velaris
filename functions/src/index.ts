import * as admin from "firebase-admin";
import * as functions from "firebase-functions";

admin.initializeApp();

// Importa HttpsError desde firebase-functions
const { HttpsError } = functions.https;

exports.sendToTopic = functions.https.onCall(async (data: any, context) => {
  console.log("Datos recibidos:", data);

  const { topic, title, body } = data;

  if (!topic || !title || !body) {
    throw new functions.https.HttpsError(
      'invalid-argument',
      'Faltan parametros: topic, title o body'
    );
  }

  const message = {
    notification: { title, body },
    topic,
  };

  try {
    const response = await admin.messaging().send(message);
    return { success: true, messageId: response };
  } catch (error) {
    console.error("Error al enviar mensaje:", error);
    throw new functions.https.HttpsError('internal', 'Error al enviar mensaje');
  }
});