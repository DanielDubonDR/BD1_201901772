import { Router } from "express";

import { 
    cargaMaisvaTablaTemporal,
    elimnarModelo,
    crearModelo,
} from "../controllers/table.controller.js";

const router = Router();

router.get("/cargartabtemp", cargaMaisvaTablaTemporal);
router.get("/eliminarmodelo", elimnarModelo);
router.get("/crearmodelo", crearModelo);

export default router;