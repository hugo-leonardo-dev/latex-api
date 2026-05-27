const express = require("express");
const fs = require("fs");
const { exec } = require("child_process");
const path = require("path");

const app = express();

app.use(express.text({ limit: "10mb" }));

app.post("/compile", async (req, res) => {
  try {
    const tex = req.body;

    const id = Date.now();

    const texPath = `/tmp/${id}.tex`;
    const pdfPath = `/tmp/${id}.pdf`;

    fs.writeFileSync(texPath, tex);

    exec(`tectonic ${texPath} --outdir /tmp`, (error, stdout, stderr) => {
      if (error) {
        console.error(stderr);

        return res.status(500).json({
          error: stderr,
        });
      }

      res.sendFile(pdfPath);
    });
  } catch (err) {
    console.error(err);

    res.status(500).json({
      error: err.message,
    });
  }
});

app.listen(3000, () => {
  console.log("running");
});
