-- Volcado de tablas basicas

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: cor1440_gen_actividadarea; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (101, 'ACOMPAÑAMIENTO PASTORAL', '', '2015-07-15', NULL, '2015-07-15 19:25:38.896977', '2015-07-15 19:25:38.896977');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (102, 'EMPRENDIMIENTO SOCIOECONOMICO', '', '2015-07-15', NULL, '2015-07-15 19:25:58.166017', '2015-07-15 19:25:58.166017');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (103, 'ACOMPAÑAMIENTO JURIDICO - LEGAL', '', '2015-07-15', NULL, '2015-07-15 19:26:21.9653', '2015-07-15 19:26:21.9653');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (104, 'FORTALECIMIENTO A LA ORGANIZACION COMUNITARIA', '', '2015-07-15', NULL, '2015-07-15 19:26:43.144367', '2015-07-15 19:26:43.144367');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (105, 'ACOMPAÑAMIENTO PSICOSOCIAL', '', '2015-07-15', NULL, '2015-07-15 19:26:55.224129', '2015-07-15 19:26:55.224129');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (106, 'RED SJR COLEGIOS', '', '2015-07-15', NULL, '2015-07-15 19:27:07.224159', '2015-07-15 19:27:07.224159');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (107, 'FORMACIÓN', '', '2015-07-15', NULL, '2015-07-15 19:28:19.051778', '2015-07-15 19:28:19.051778');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (108, 'PREVENCIÓN DEL DESPLAZAMIENTO', '', '2015-07-21', NULL, '2015-07-21 15:34:54.513132', '2015-07-21 15:34:54.513132');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (109, 'PREVENCIÓN DEL RECLUTAMIENTO FORZADO DE NNAJ', '', '2015-07-21', NULL, '2015-07-21 15:35:10.73305', '2015-07-21 15:35:10.73305');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (110, 'INCIDENCIA LOCAL/REGIONAL', '', '2015-07-21', NULL, '2015-07-21 15:35:45.0507', '2015-07-21 15:35:45.0507');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (111, 'INCIDENCIA NACIONAL', '', '2015-07-21', NULL, '2015-07-21 15:35:58.471572', '2015-07-21 15:35:58.471572');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (13, 'GESTIÓN DE LA INFORMACION', '', '2015-04-18', NULL, '2015-04-18 10:58:22.231407', '2015-07-01 16:38:04.737559');
INSERT INTO cor1440_gen_actividadarea (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (9, 'VOLUNTARIADO', '', '2015-03-10', NULL, '2015-03-10 11:12:30.464003', '2015-03-10 11:12:30.464003');


--
-- Name: cor1440_gen_actividadarea_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cor1440_gen_actividadarea_id_seq', 111, true);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: cor1440_gen_actividadtipo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'ORGANIZACIÓN DE ACTIVIDAD DE FORMACIÓN', '', '2015-04-17', NULL, '2015-04-17 21:47:31.920052', '2015-04-17 21:47:31.920052');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (10, 'ORGANIZACIÓN DE CAMPAÑA', '', '2015-04-18', NULL, '2015-04-18 10:58:02.08154', '2015-04-18 10:58:02.08154');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (11, 'MISIÓN HUMANITARIA', '', '2015-04-18', NULL, '2015-04-18 10:58:22.231407', '2015-04-18 10:58:22.231407');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (12, 'SEGUIMIENTO A CASO', '', '2015-04-18', NULL, '2015-04-18 10:58:52.741712', '2015-04-18 10:58:52.741712');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (13, 'SEGUIMIENTO A PLANEACIÓN,', '', '2015-04-18', NULL, '2015-04-18 10:59:06.40352', '2015-04-18 10:59:06.40352');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (14, 'SEGUIMIENTO A PROYECTO', '', '2015-04-18', NULL, '2015-04-18 10:59:21.721801', '2015-04-18 10:59:21.721801');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (15, 'VISITA TÉCNICA', '', '2015-04-18', NULL, '2015-04-18 10:59:42.391942', '2015-04-18 10:59:42.391942');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'PARTICIPACIÓN EN ACTIVIDAD DE FORMACIÓN', '', '2015-04-17', NULL, '2015-04-17 21:52:35.802212', '2015-04-17 21:52:35.802212');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'PARTICIPACIÓN EN REUNIÓN', '', '2015-04-17', NULL, '2015-04-17 21:52:48.803678', '2015-04-17 21:52:48.803678');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (4, 'PARTICIPACIÓN EN REUNIÓN ESTRATÉGICA', '', '2015-04-17', NULL, '2015-04-17 21:53:01.021493', '2015-04-17 21:53:01.021493');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'PRESENTACIÓN DE PONENCIA EN EVENTO', '', '2015-04-17', NULL, '2015-04-17 21:53:13.22205', '2015-04-17 21:53:13.22205');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (6, 'MONITOREO, SUPERVISIÓN, EVALUACIÓN', '', '2015-04-17', NULL, '2015-04-17 21:53:26.363204', '2015-04-18 11:01:13.499746');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (7, 'ORGANIZACIÓN DE EVENTO', '', '2015-04-18', NULL, '2015-04-18 10:54:24.247319', '2015-04-18 10:54:24.247319');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (8, 'RESPUESTA A SOLICITUD DE INFORMACIÓN', '', '2015-04-18', NULL, '2015-04-18 10:56:01.181889', '2015-04-18 11:00:33.221088');
INSERT INTO cor1440_gen_actividadtipo (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (9, 'ORGANIZACIÓN DE ACTIVIDAD CULTURAL/ARTÍSTICA', '', '2015-04-18', NULL, '2015-04-18 10:57:38.55163', '2015-04-18 11:00:02.131731');


--
-- Name: cor1440_gen_actividadtipo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cor1440_gen_actividadtipo_id_seq', 100, true);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: cor1440_gen_financiador; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: cor1440_gen_financiador_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cor1440_gen_financiador_id_seq', 100, true);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: cor1440_gen_proyecto; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cor1440_gen_proyecto (id, nombre, observaciones, fechainicio, fechacierre, resultados, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (101, 'ACCIÓN HUMANITARIA', '', NULL, NULL, '', '2015-07-01', NULL, '2015-07-01 16:28:00.948626', '2015-07-01 16:28:00.948626');
INSERT INTO cor1440_gen_proyecto (id, nombre, observaciones, fechainicio, fechacierre, resultados, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (104, 'INCIDENCIA POLÍTICA', '', NULL, NULL, '', '2015-07-01', NULL, '2015-07-01 16:30:20.222396', '2015-07-01 16:30:20.222396');
INSERT INTO cor1440_gen_proyecto (id, nombre, observaciones, fechainicio, fechacierre, resultados, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (105, 'INTEGRACIÓN LOCAL', '', NULL, NULL, '', '2015-07-01', NULL, '2015-07-01 16:30:35.161691', '2015-07-01 16:30:35.161691');
INSERT INTO cor1440_gen_proyecto (id, nombre, observaciones, fechainicio, fechacierre, resultados, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (108, 'PREVENCIÓN', '', NULL, NULL, '', '2015-07-01', NULL, '2015-07-01 16:31:29.726534', '2015-07-01 16:31:29.726534');
INSERT INTO cor1440_gen_proyecto (id, nombre, observaciones, fechainicio, fechacierre, resultados, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (109, 'PROYECTOS', '', NULL, NULL, '', '2015-07-01', NULL, '2015-07-01 16:32:16.593125', '2015-07-01 16:32:16.593125');
INSERT INTO cor1440_gen_proyecto (id, nombre, observaciones, fechainicio, fechacierre, resultados, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (112, 'FORTALECIMIENTO INSTITUCIONAL ', '', NULL, NULL, '', '2015-07-15', NULL, '2015-07-15 19:24:10.851455', '2015-07-15 19:24:10.851455');
INSERT INTO cor1440_gen_proyecto (id, nombre, observaciones, fechainicio, fechacierre, resultados, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (113, 'COMUNICACIONES', '', NULL, NULL, '', '2015-07-15', NULL, '2015-07-15 19:24:45.769515', '2015-07-15 19:24:45.769515');
INSERT INTO cor1440_gen_proyecto (id, nombre, observaciones, fechainicio, fechacierre, resultados, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (114, 'DIRECCIÓN NACIONAL', '', NULL, NULL, '', '2015-07-15', NULL, '2015-07-15 19:32:11.667547', '2015-07-15 19:32:11.667547');
INSERT INTO cor1440_gen_proyecto (id, nombre, observaciones, fechainicio, fechacierre, resultados, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (115, 'GESTIÓN ADMINISTRATIVA', '', NULL, NULL, '', '2015-07-21', NULL, '2015-07-21 15:30:24.893391', '2015-07-21 15:30:31.300962');


--
-- Name: cor1440_gen_proyecto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cor1440_gen_proyecto_id_seq', 115, true);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: cor1440_gen_proyectofinanciero; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- Name: cor1440_gen_proyectofinanciero_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cor1440_gen_proyectofinanciero_id_seq', 100, true);


--
-- PostgreSQL database dump complete
--

--
-- PostgreSQL database dump
--

SET statement_timeout = 0;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

--
-- Data for Name: cor1440_gen_rangoedadac; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO cor1440_gen_rangoedadac (id, nombre, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones) VALUES (1, 'De 0 a 11', 0, 10, '2014-02-11', NULL, '2014-03-07 19:19:02.690768', NULL, NULL);
INSERT INTO cor1440_gen_rangoedadac (id, nombre, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones) VALUES (2, 'De 12 a 17', 0, 10, '2014-02-11', NULL, '2014-03-07 19:19:02.690768', NULL, NULL);
INSERT INTO cor1440_gen_rangoedadac (id, nombre, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones) VALUES (3, 'De 18 a 25', 16, 25, '2014-02-11', NULL, '2014-03-07 19:19:09.515802', NULL, NULL);
INSERT INTO cor1440_gen_rangoedadac (id, nombre, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones) VALUES (4, 'De 26 a 45', 26, 45, '2014-02-11', NULL, '2014-03-07 19:19:09.527935', NULL, NULL);
INSERT INTO cor1440_gen_rangoedadac (id, nombre, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones) VALUES (5, 'De 46 a 60', 46, 60, '2014-02-11', NULL, '2014-03-07 19:19:09.539237', NULL, NULL);
INSERT INTO cor1440_gen_rangoedadac (id, nombre, limiteinferior, limitesuperior, fechacreacion, fechadeshabilitacion, created_at, updated_at, observaciones) VALUES (6, 'De 61 en adelante', 61, NULL, '2014-02-11', NULL, '2014-03-07 19:19:09.549437', NULL, NULL);


--
-- Name: cor1440_gen_rangoedadac_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('cor1440_gen_rangoedadac_id_seq', 100, true);


--
-- PostgreSQL database dump complete
--

