import {CallableResponse, isNonEmptyStringArray} from "./common";
import {getFirestore} from "firebase-admin/firestore";
import {getMessaging} from "firebase-admin/messaging";

export type UserNotification = {
    userId: string,
    title: string,
    body: string,
    data?: {
        [key: string]: string
    },
}

export const sendNotificationToUser = async (
    notification: UserNotification,
): Promise<CallableResponse | null> => {
    const userDoc = await getFirestore()
        .collection("users")
        .doc(notification.userId)
        .get();
    const user = userDoc.data();
    if (!user) {
        return {
            status: 404,
            error: "no user",
        };
    }

    const fcmTokens = user.fcmTokens;
    if (!isNonEmptyStringArray(fcmTokens)) {
        return {
            status: 404,
            error: "no fcmTokens",
        };
    }

    const message = {
        data: notification.data,
        tokens: fcmTokens,
        notification: {
            title: notification.title,
            body: notification.body,
        },
    };

    // Wait 10s
    await new Promise((resolve) => setTimeout(resolve, 10_000));

    const response = await getMessaging().sendEachForMulticast(message);
    if (response.failureCount > 0) {
        const failedTokens: string[] = [];
        response.responses.forEach((r, i) => {
            if (!r.success) {
                failedTokens.push(fcmTokens[i]);
            }
        });

        console.log(`List of tokens that caused failures: ${failedTokens}`);
        return null;
    }

    return null;
};
