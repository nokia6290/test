import {CallableRequest} from "firebase-functions/v2/https";
import {getFirestore} from "firebase-admin/firestore";
import {isNonEmptyString} from "./common";
import {firestore} from "firebase-admin";
import FieldValue = firestore.FieldValue;

export const articleAdd = async (request: CallableRequest) => {
    const userId = request.auth?.uid;
    if (!userId) {
        return {
            status: 401,
            error: "no userId",
        };
    }

    const title = request.data.title;
    if (!isNonEmptyString(title)) {
        return {
            status: 400,
            error: "no title",
        };
    }

    const subtitle = request.data.subtitle;
    if (!isNonEmptyString(subtitle)) {
        return {
            status: 400,
            error: "no subtitle",
        };
    }

    const text = request.data.text;
    if (!isNonEmptyString(text)) {
        return {
            status: 400,
            error: "no text",
        };
    }

    const docRef = await getFirestore().collection("articles").add({
        title: title,
        subtitle: subtitle,
        text: text,
        imageUrl: "",
        createdAt: FieldValue.serverTimestamp(),
    });

    return {
        status: 200,
        data: {
            id: docRef.id,
        },
    };
};
