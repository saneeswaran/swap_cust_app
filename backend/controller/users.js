const User = require("../models/User");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");

// Register User
exports.registerUser = async (req, res) => {
  const { name, email, password, image } = req.body;

  try {
    const existsUser = await User.findOne({ email });
    if (existsUser) return res.status(400).json({ success: false, message: "User already exists" });

    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = new User({ name, email, password: hashedPassword, image });
    await newUser.save();

    res.json({ success: true, message: "User registered successfully", user: newUser });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};

// Login User
exports.loginUser = async (req, res) => {
  const { email, password } = req.body;

  try {
    const user = await User.findOne({ email });
    if (!user) return res.status(404).json({ success: false, message: "User not found" });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ success: false, message: "Invalid credentials" });

    const token = jwt.sign({ id: user._id }, process.env.JWT_SECRET, { expiresIn: "1h" });

    res.json({ success: true, token, user });
  } catch (error) {
    res.status(500).json({ success: false, message: error.message });
  }
};
