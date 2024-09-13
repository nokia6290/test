import {CallableRequest} from "firebase-functions/v2/https";
import {getFirestore} from "firebase-admin/firestore";
import {isNonEmptyString} from "./common";
import {firestore} from "firebase-admin";
import FieldValue = firestore.FieldValue;

export const sendFeedback = async (request: CallableRequest) => {
    const userId = request.auth?.uid ?? null;

    const email = request.data.email;
    if (!isNonEmptyString(email)) {
        return {
            status: 400,
            error: "no email",
        };
    }

    const message = request.data.message;
    if (!isNonEmptyString(message)) {
        return {
            status: 400,
            error: "no message",
        };
    }

    await getFirestore().collection("feedbackMessages").add({
        email: email,
        message: message,
        userId: userId,
        timestamp: FieldValue.serverTimestamp(),
    });

    return {
        status: 200,
        data: {},
    };
};
