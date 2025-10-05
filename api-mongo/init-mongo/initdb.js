db = db.getSiblingDB('EPARVIER');
if (db.rappels.countDocuments() === 0) {
  db.rappels.insertMany([
    {
      titre: "Ma première note",
      contenu: "Ceci a été injecté automatiquement une seule fois.",
      date: new Date()
    },
    {
      titre: "Deuxième note",
      contenu: "Je ne serai pas dupliquée.",
      date: new Date()
    }
  ]);

  print("✅ Données initiales insérées !");
} else {
  print("🔎 Données déjà présentes, rien à insérer.");
}