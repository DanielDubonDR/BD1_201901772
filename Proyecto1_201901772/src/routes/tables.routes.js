import { Router } from "express";

import { 
    eliminarTablaTemporal,
    cargaMaisvaTablaTemporal,
    elimnarModelo,
    crearModelo,
    cargarModelo
} from "../controllers/table.controller.js";

const router = Router();

router.get("/eliminartabtemp", eliminarTablaTemporal);
router.get("/cargartabtemp", cargaMaisvaTablaTemporal);
router.get("/eliminarmodelo", elimnarModelo);
router.get("/crearmodelo", crearModelo);
router.get("/cargarmodelo", cargarModelo);

export default router;