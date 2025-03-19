const express = require("express");
const app = express();
const dotenv = require("dotenv");
const path = require("path");
const connection = require("./config/db");

// Load environment variables
dotenv.config({ path: path.join(__dirname, ".env") });

// Import routes
const authRouter = require("./routes/user");

app.use(express.json());

// Routes
app.use("/users", authRouter);

// Error handling middleware
app.use((err, req, res, next) => {
  res.status(500).json({ message: err.message });
});

// Connect to database
connection();

// Start server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
