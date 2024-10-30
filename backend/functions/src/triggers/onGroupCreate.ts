/// When a group is created, we must add the owner to the group members

import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

import { onDocumentCreated } from "firebase-functions/v2/firestore";
import { Meta } from "../models/meta";

export const onGroupCreate = onDocumentCreated(
	"groups/{groupId}",
	async (event) => {
		functions.logger.info("[onDocumentCreated] onGroupCreate starting");
		functions.logger.info("groupId: ", event.params.groupId);

		const data = event.data?.data();

		if (!data) {
			functions.logger.error("No data in event");
			return;
		}

		const meta = data.meta;

		if (
			!meta ||
			!meta.createdBy ||
			typeof meta.createdBy !== "string" ||
			!meta.createdAt ||
			typeof meta.createdAt !== "object"
		) {
			functions.logger.error("Invalid data: " + JSON.stringify(data));
			return;
		}

		const groupId = event.params.groupId;

		await onGroupCreated({ groupId, meta });
	}
);

interface GroupCreatedEvent {
	groupId: string;
	meta: Meta;
}

async function onGroupCreated(event: GroupCreatedEvent) {
	functions.logger.info("[onGroupCreated] STARTED");
	functions.logger.info("groupId: ", event.groupId);

	const groupId = event.groupId;

	const groupMembersRef = admin
		.firestore()
		.collection("groups")
		.doc(groupId)
		.collection("members");
	try {
		await groupMembersRef
			.doc(event.meta.createdBy)
			.set({ userId: event.meta.createdBy, meta: event.meta });

		functions.logger.info("[onGroupCreated] Added owner to group members");
	} catch (error) {
		functions.logger.error(
			"[onGroupCreated] Error adding owner to group members: ",
			error
		);
	}

	// Update the group memberIds array
	const groupRef = admin.firestore().collection("groups").doc(groupId);

	try {
		await groupRef.update({
			ownerId: event.meta.createdBy,
			memberIds: admin.firestore.FieldValue.arrayUnion(event.meta.createdBy),
		});

		functions.logger.info("[onGroupCreated] Updated group memberIds");
	} catch (error) {
		functions.logger.error(
			"[onGroupCreated] Error updating group memberIds: ",
			error
		);
		return;
	}
	functions.logger.info("[onGroupCreated] SUCCESS");
}
