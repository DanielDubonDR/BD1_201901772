import { Router } from "express";
import { 
    getConsulta1,
    getConsulta2,
    getConsulta3,
    getConsulta4,
    getConsulta5,
    getConsulta6,
    getConsulta7,
    getConsulta8,
    getConsulta9,
    getConsulta10,
    getConsulta11
} from "../controllers/consultas.controller.js";

const router = Router();

router.get("/consulta1", getConsulta1);
router.get("/consulta2", getConsulta2);
router.get("/consulta3", getConsulta3);
router.get("/consulta4", getConsulta4);
router.get("/consulta5", getConsulta5);
router.get("/consulta6", getConsulta6);
router.get("/consulta7", getConsulta7);
router.get("/consulta8", getConsulta8);
router.get("/consulta9", getConsulta9);
router.get("/consulta10", getConsulta10);
router.get("/consulta11", getConsulta11);

export default router;