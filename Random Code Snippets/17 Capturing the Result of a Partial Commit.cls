// Insert & Update
List<Database.SaveResult> srs = Database.insert(contacts, false);
List<Database.SaveResult> srs = Database.update(contacts, false);
sr.getErrors();
sr.getId();
sr.isSuccess()

// Upsert
List<Database.UpsertResult> urs = Database.upsert(contacts, false);
ur.getErrors()
ur.getId()
ur.isCreated()
ur.isSuccess()

// Delete
List<Database.DeleteResult> drs = Database.delete(contacts, false);
dr.getErrors();
dr.getId();
dr.isSuccess()

// UnDelete
List<Database.UnDeleteResult> udrs = Database.undelete(contacts, false);
udr.getErrors();
udr.getId();
udr.isSuccess()