/// <reference path="../pb_data/types.d.ts" />
// Counts tutor questions per user per day. No access rules: only the server hook can touch it.
migrate((app) => {
  const users = app.findCollectionByNameOrId("users");
  const collection = new Collection({
    type: "base",
    name: "tutor_usage",
    listRule: null, viewRule: null, createRule: null, updateRule: null, deleteRule: null,
    fields: [
      { type: "relation", name: "user", required: true, collectionId: users.id, maxSelect: 1, cascadeDelete: true },
      { type: "text", name: "day", required: true },
      { type: "number", name: "count" },
    ],
    indexes: ["CREATE UNIQUE INDEX idx_tutor_usage_user_day ON tutor_usage (user, day)"],
  });
  app.save(collection);
}, (app) => {
  app.delete(app.findCollectionByNameOrId("tutor_usage"));
});
