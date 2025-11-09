mkdir -p src
cat > src/index.js <<'EOF'
import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";

function App() {
  return (
    <div style={{ textAlign: "center", marginTop: "50px" }}>
      <h1>Hello Admin Panel 👋</h1>
      <p>Connected to Render backend successfully!</p>
    </div>
  );
}

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(<App />);
EOF
