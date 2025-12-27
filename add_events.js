// add_events.js
const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

const events = [
  {
    title: "Dance Night",
    description: "College dance competition with group and solo categories.",
    date: admin.firestore.Timestamp.fromDate(new Date("2025-12-10T18:00:00Z")),
    location: "Auditorium",
    category: "Dance",
    createdBy: "admin123",
  },
  {
    title: "Stand-up Comedy Evening",
    description: "Open mic stand-up comedy by students and faculty.",
    date: admin.firestore.Timestamp.fromDate(new Date("2025-12-12T19:00:00Z")),
    location: "Seminar Hall 2",
    category: "Comedy",
    createdBy: "admin123",
  },
  {
    title: "8th Mile Concert",
    description: "Annual cultural fest headliner concert.",
    date: admin.firestore.Timestamp.fromDate(new Date("2025-12-20T20:00:00Z")),
    location: "Main Ground",
    category: "Fest",
    createdBy: "admin123",
  },
  {
    title: "Tech Workshop: Flutter",
    description: "Hands-on workshop building a mobile app with Flutter.",
    date: admin.firestore.Timestamp.fromDate(new Date("2025-12-08T14:00:00Z")),
    location: "Lab A-101",
    category: "Workshop",
    createdBy: "admin123",
  },
  {
    title: "Football Tournament",
    description: "Inter-department football league.",
    date: admin.firestore.Timestamp.fromDate(new Date("2025-12-15T09:00:00Z")),
    location: "Sports Ground",
    category: "Sports",
    createdBy: "admin123",
  },
  {
    title: "Startup Pitch Day",
    description: "Students pitch startup ideas to judges.",
    date: admin.firestore.Timestamp.fromDate(new Date("2025-12-18T11:00:00Z")),
    location: "Innovation Center",
    category: "Seminar",
    createdBy: "admin123",
  },
];

async function addEvents() {
  for (const event of events) {
    await db.collection("events").add(event);
    console.log(`Added: ${event.title}`);
  }
  console.log("✅ All events added!");
  process.exit(0);
}

addEvents().catch((e) => {
  console.error(e);
  process.exit(1);
});
