# 🎓 Campus Events Management App (RV University)

A cross-platform Flutter application designed to simplify event management at RV University.  
It allows students to explore and register for campus events, and enables administrators to create, manage, and analyze event participation—all from one intuitive interface.

---

## 🚀 Tech Stack

**Frontend:** Flutter (Dart, Material Design 3)  
**Backend:** Firebase (Authentication, Firestore, Hosting)  
**IDE:** VS Code / Android Studio  
**Platform Support:** Android, Web (Chrome / Edge)

---

## ✨ Key Features

### 👤 Student Features
- View all upcoming campus events 🗓️  
- Register for events and track participation 🎟️  
- Explore past events and campus rules 📚  
- Contact event organizers via phone, email, or map link 📞  
- Real-time updates of newly added events 🔄  

### 🛠️ Admin Features
- Role-based secure login 🔐  
- Add new events with title, description, date, and location 🏫  
- Manage all existing events (edit/delete/view)  
- Track registrations in real-time  
- Dashboard with live statistics 📊  

| Module | Description |
|--------|--------------|
| Auth Module | Firebase authentication, secure login/signup |
| Event Module | CRUD operations on events, real-time sync with Firestore |
| Registration Module | Student registration and attendance tracking |
| Admin Dashboard | Event analytics and controls |
| Contact & Help | Organizer details, map integration, feedback button |
| Past Events | Static info and gallery for completed events |

---

## 🧠 Architecture

**Three-tier architecture:**
- **Presentation Layer:** Flutter UI widgets (EventsPage, EventFormPage, PastEventsPage)
- **Business Logic Layer:** Services (`AuthService`, `EventService`, `RegistrationService`)
- **Data Layer:** Firebase Firestore for event and user data

---

## 🧪 Testing & Performance
- 100% test pass rate (unit, integration, and system tests)
- Average Firestore query time: **350ms**
- App startup time: **2.5 seconds**
- Real-time updates verified with multiple sessions

<img width="1288" height="873" alt="image" src="https://github.com/user-attachments/assets/58633083-072a-4b56-b3d1-ea728518068f" />
<img width="1282" height="876" alt="image" src="https://github.com/user-attachments/assets/239d07b9-39a7-467b-b336-6f90ff427bdc" />
<img width="1277" height="864" alt="image" src="https://github.com/user-attachments/assets/3def9bc7-4e4e-4346-a185-15810630c027" />
<img width="1287" height="867" alt="image" src="https://github.com/user-attachments/assets/37b87466-2de1-446a-9002-3f28b32c3891" />
<img width="1262" height="884" alt="image" src="https://github.com/user-attachments/assets/bc3abae7-2647-4ded-a826-8e45aa40315c" />
<img width="1281" height="859" alt="image" src="https://github.com/user-attachments/assets/72017d41-775b-4357-b082-1c253109dc9a" />

to tun the app
>>cd C:\campus_events\campus_events
>> flutter clean
>> flutter pub get
>> flutter run -d chrome
---


## 🧱 Firestore Data Structure

