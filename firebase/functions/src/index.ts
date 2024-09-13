/* eslint-disable max-len */
import * as admin from "firebase-admin";
import * as functions from "firebase-functions";
import * as user from "./user";
import * as article from "./article";
import * as feedback from "./feedback";
import {CallableOptions, onCall} from "firebase-functions/v2/https";

const euFunctions = functions.region("europe-west1");
const options: CallableOptions = {
    region: "europe-west1",
    maxInstances: 5,
};

// Initialize
admin.initializeApp();

// User
exports.onUserCreated = euFunctions.auth.user().onCreate(user.onUserCreated);
exports.setUserPhoto = onCall(options, user.setUserPhoto);
exports.addUserFcmToken = onCall(options, user.addUserFcmToken);
exports.removeUserFcmToken = onCall(options, user.removeUserFcmToken);
exports.sendUserNotification = onCall(options, user.sendUserNotification);

// Article
exports.articleAdd = onCall(options, article.articleAdd);

// Feedback
exports.sendFeedback = onCall(options, feedback.sendFeedback);
