/// <reference path="../pb_data/types.d.ts" />
// One progress record per user. Users can only see and change their own.
migrate((app) => {
  const users = app.findCollectionByNameOrId("users");
  const collection = new Collection({
    type: "base",
    name: "progress",
    listRule:   "user = @request.auth.id",
    viewRule:   "user = @request.auth.id",
    createRule: "@request.auth.id != '' && @request.body.user = @request.auth.id",
    updateRule: "user = @request.auth.id && @request.body.user:isset = false",
    deleteRule: "user = @request.auth.id",
    fields: [
      { type: "relation", name: "user", required: true, collectionId: users.id, maxSelect: 1, cascadeDelete: true },
      { type: "json", name: "data", maxSize: 200000 },
      { type: "autodate", name: "updated", onCreate: true, onUpdate: true },
    ],
    indexes: ["CREATE UNIQUE INDEX idx_progress_user ON progress (user)"],
  });
  app.save(collection);
}, (app) => {
  app.delete(app.findCollectionByNameOrId("progress"));
});
