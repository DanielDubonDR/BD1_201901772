import express from "express";
import morgan from "morgan";
import cors from "cors";
import handlerTest from "./routes/test.routes.js";
import handlerConsultas from "./routes/consultas.routes.js";
import handlerTables from "./routes/tables.routes.js";

const app = express();

app.use(express.json());
app.use(morgan("dev"));
app.use(cors());

app.use(handlerTest);
app.use(handlerConsultas);
app.use(handlerTables);

app.listen(4000);
console.log(`Server on port 4000`);