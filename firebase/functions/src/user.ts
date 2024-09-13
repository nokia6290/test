import {logger} from "firebase-functions";
import {getFirestore} from "firebase-admin/firestore";
import {UserRecord} from "firebase-admin/auth";
import {firestore} from "firebase-admin";
import {CallableRequest} from "firebase-functions/v2/https";
import {sendNotificationToUser} from "./notification";
import FieldValue = firestore.FieldValue;
import {isNonEmptyString} from "./common";

// Creates a new /users Firestore document when a Firebase Auth user is created.
export const onUserCreated = async (userRecord: UserRecord) => {
    const user = {
        email: userRecord.email,
        name: userRecord.displayName,
        imageUrl: userRecord.photoURL,
        createdAt: FieldValue.serverTimestamp(),
    };

    await getFirestore().collection("users").doc(userRecord.uid).set(user);
    logger.info("User created", user);
};

export const setUserPhoto = async (request: CallableRequest) => {
    const userId = request.auth?.uid;
    if (!userId) {
        return {
            status: 401,
            error: "no userId",
        };
    }

    const imageUrl = request.data.imageUrl;
    if (!isNonEmptyString(imageUrl)) {
        return {
            status: 400,
            error: "no imageUrl",
        };
    }

    await getFirestore().collection("users").doc(userId).update({
        imageUrl: imageUrl,
    });

    return {
        status: 200,
        data: {},
    };
};

export const addUserFcmToken = async (request: CallableRequest) => {
    const userId = request.auth?.uid;
    if (!userId) {
        return {
            status: 401,
            error: "no userId",
        };
    }

    const token = request.data.token;
    if (!isNonEmptyString(token)) {
        return {
            status: 400,
            error: "no token",
        };
    }

    await getFirestore().collection("users").doc(userId).update({
        fcmTokens: FieldValue.arrayUnion(token),
    });

    return {
        status: 200,
        data: {},
    };
};

export const removeUserFcmToken = async (request: CallableRequest) => {
    const userId = request.auth?.uid;
    if (!userId) {
        return {
            status: 401,
            error: "no userId",
        };
    }

    const token = request.data.token;
    if (!isNonEmptyString(token)) {
        return {
            status: 400,
            error: "no token",
        };
    }

    await getFirestore().collection("users").doc(userId).update({
        fcmTokens: FieldValue.arrayRemove(token),
    });

    return {
        status: 200,
        data: {},
    };
};

export const sendUserNotification = async (request: CallableRequest) => {
    const userId = request.auth?.uid;
    if (!userId) {
        return {
            status: 401,
            error: "no userId",
        };
    }

    const error = await sendNotificationToUser({
        userId: userId,
        title: "Remote Notification",
        body: "This is a remote notification. Click to open Feedback Page.",
        data: {
            type: "feedback",
        },
    });

    if (error) {
        return error;
    }

    return {
        status: 200,
        data: {},
    };
};
