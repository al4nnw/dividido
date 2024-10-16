/// When a group is created, we must add the owner to the group members

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

export const onGroupCreate = functions.firestore
	.document("groups/{groupId}")
	.onCreate(async (snapshot, context) => {
		const data = snapshot.data();
		const ownerId = data.meta.createdBy;
		const groupId = context.params.groupId;

		const groupMembersRef = admin
			.firestore()
			.collection("groups")
			.doc(groupId)
			.collection("members");
		await groupMembersRef.add({ userId: ownerId });
	});
