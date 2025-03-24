# 🎮 Moonrider Task - Reward Coins Application  

A **Flutter** application implementing a **coin-based reward system** with an **hourly scratch card** and **redemption mechanism**.  
This project follows **Clean Architecture** principles and uses **Bloc for state management**.


## 📸 Screenshots  

<table>
  <tr>
    <td><img src="https://github.com/user-attachments/assets/e5824ee4-c49a-4a87-9726-5e7cf981626f" width="300"/></td>
    <td><img src="https://github.com/user-attachments/assets/fdd62542-f03b-4bfa-bea7-341a8348c647" width="300"/></td>
  </tr>
</table>
 

## 🎥 Demo Video  
[Watch Demo](https://github.com/Xyz31/moonrider_ai/blob/main/Screen_Recording_demo.mp4)  

---

## 🚀 Features  

### 🏠 Home Screen  
✅ **Coin Balance:** Displays the current coin balance (default **1000 coins**)  
✅ **Hourly Scratch Card:** Users can scratch every **1 hour** to earn between **50-500 coins**  
✅ **Scratch Effect:** Simulated without third-party packages  
✅ **Next Scratch Timer:** Displays the next available scratch time  

### 🛒 Redemption Store  
✅ **Redeemable Items:** List of rewards (e.g., **Discount Coupon, Gift Card**)  
✅ **Sufficient Balance:** Allows redemption if the user has enough coins  
✅ **Notify Redeem Offer:** Shows an alert if offers are redeemed  
✅ **Balance Deduction:** Deducts coins after successful redemption  

### 📜 History Screen  
✅ **Transaction Logs:** Displays **scratch rewards & redemptions** with timestamps  

---

## 🔧 Technical Requirements  

### 📌 Architecture  
✅ **Clean Architecture** (Separation into **Data, Domain, and Presentation layers**)  
✅ **State Management:** Uses **Bloc for state transitions**  
✅ **Mocked Data:** No external APIs or databases  

### ✅ Testing  
✔ **Scratch functionality:** Ensures only **one scratch per hour**  
✔ **Redemption process:** Validates successful & failed transactions  
✔ **Balance Updates:** Confirms correct deductions & additions  

### 📱 Compatibility  
✅ Runs on **iOS & Android**  

---

## 📂 Submission Requirements  
✔ **🎥 Screen Recording:** Demonstrates all core features  
✔ **📖 Code Explanation:** Details **Bloc state management**  


---

## 🛠️ Setup Instructions  
1️⃣ Clone the repository  
```sh
git clone https://github.com/Xyz31/moonrider_ai.git
cd moonrider_ai
