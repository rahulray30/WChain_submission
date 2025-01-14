
# Time-Bound Whitelisted Lottery

## **Purpose**
A time-bound lottery system where only whitelisted participants can join. Each participant can enter the lottery only once during a specific time window. At the end of the lottery, a random winner is chosen automatically, and the prize pool is distributed.

---

## **Key Features**

### **1. Whitelisted Addresses**
- Only addresses added by the owner can participate in the lottery.
- Ensures restricted access and prevents unauthorized entries.

### **2. Fair Usage**
- Each user can participate in the lottery only once.
- This is enforced using the `hasParticipated` mapping, which tracks user participation.

### **3. Time-Bound Functionality**
- The lottery operates only within a specified time window.
- Ensures participation is limited to a predefined period.

### **4. Automated Outcome**
- At the end of the lottery, a random winner is selected using a pseudo-random number generator.
- The prize pool is automatically transferred to the winner, ensuring a seamless distribution.

---

## **How It Works**

1. **Initialization**
   - The owner sets the start and end times for the lottery.
   - The owner adds participants to the whitelist.

2. **Participation**
   - Whitelisted users can enter the lottery by calling the `enterLottery()` function.
   - The contract ensures that users can participate only once.

3. **Random Winner Selection**
   - Once the lottery ends, the contract selects a winner using a pseudo-random number generator.
   - The prize pool is transferred to the winner automatically.

4. **Owner Controls**
   - The owner can manage the whitelist and adjust the lottery parameters before the start.

---

## **Security Considerations**

1. **Whitelist Integrity**
   - Only the owner can add or remove addresses from the whitelist.

2. **Fairness**
   - Participation is tracked using the `hasParticipated` mapping to prevent multiple entries.

3. **Randomness**
   - A pseudo-random number generator is used to ensure fair winner selection. Consider integrating an oracle (e.g., Chainlink VRF) for improved randomness.

4. **Time Validation**
   - Participation is allowed only within the specified time window, enforced through start and end time checks.

---

## **Usage Instructions**

1. **Deployment**
   - Deploy the contract to the desired blockchain.
   - Set the lottery start and end times during deployment.

2. **Whitelist Management**
   - Add participants to the whitelist using the `addToWhitelist(address)` function.

3. **Participation**
   - Whitelisted users can call `enterLottery()` to join the lottery.

4. **Finalization**
   - After the lottery ends, the winner is selected automatically, and the prize pool is transferred.





