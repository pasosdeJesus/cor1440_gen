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


--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

SET statement_timeout = 0;

SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: sectorapc; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (1, 'SIN INFORMACIÓN', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (10, 'ENTES UNIVERSITARIOS AUTÓNOMOS', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (11, 'ESTADÍSTICAS', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (12, 'FUNCIÓN PÚBLICA', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (13, 'HACIENDA Y CRÉDITO PÚBLICO', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (14, 'INCLUSIÓN SOCIAL Y RECONCILIACIÓN', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (15, 'INTELIGENCIA ESTRATÉGICA Y CONTRAINTELIGENCIA', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (16, 'INTERIOR', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (17, 'JUSTICIA Y DEL DERECHO', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (18, 'MINAS Y ENERGÍA', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (19, 'ORGANISMOS AUTÓNOMOS', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (2, 'AGRICULTURA Y DESARROLLO RURAL', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (20, 'ORGANISMOS DE CONTROL', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (21, 'ORGANIZACIÓN ELECTORAL', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (22, 'PLANEACIÓN', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (23, 'PRESIDENCIA DE LA REPÚBLICA', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (24, 'PROTECCIÓN SOCIAL', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (25, 'RAMA JUDICIAL', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (26, 'RAMA LEGISLATIVA', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (27, 'RELACIONES EXTERIORES', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (28, 'SALUD Y PROTECCIÓN SOCIAL', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (29, 'TRANSPORTE', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (3, 'AMBIENTE Y DESARROLLO SOSTENIBLE', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (30, 'VIVIENDA CIUDAD Y TERRITORIO', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (4, 'CIENCIA, TECNOLOGÍA E INNOVACIÓN, COMERCIO, INDUSTRIA Y TURISMO', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (5, 'CORPORACIONES AUTÓNOMAS REGIONALES Y DE DESARROLLO SOSTENIBLE', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (6, 'CULTURA', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (7, 'DEFENSA NACIONAL', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (8, 'DEPORTE', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');
INSERT INTO public.cor1440_gen_sectorapc (id, nombre, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at) VALUES (9, 'EDUCACIÓN NACIONAL', NULL, '2018-04-20', NULL, '2018-04-20 00:00:00', '2018-04-20 00:00:00');


--
-- Name: sectorapc_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cor1440_gen_sectorapc_id_seq', 101, true);


--
-- PostgreSQL database dump complete
--



--
-- Data for Name: heb412_gen_plantillahcm; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.heb412_gen_plantillahcm (id, ruta, fuente, licencia, vista, nombremenu, filainicial) VALUES (5, 'plantillas/listado_de_actividades.ods', 'Pasos de Jesús', 'Dominio Público', 'Actividad', 'Listado Completo de Actividades', 5);
INSERT INTO public.heb412_gen_plantillahcm (id, ruta, fuente, licencia, vista, nombremenu, filainicial) VALUES (40, 'plantillas/listado_de_proyectos.ods', 'Pasos de Jesús', 'Dominio público de acuerdo a legislación colombiana', 'Proyecto', 'Listado de proyectos', 5);

--
-- Data for Name: heb412_gen_campoplantillahcm; Type: TABLE DATA; Schema: public; Owner: -
--


INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (500, 5, 'id', 'A');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (501, 5, 'nombre', 'B');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (502, 5, 'fecha', 'C');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (503, 5, 'lugar', 'D');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (504, 5, 'oficina', 'E');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (505, 5, 'convenio_financiado', 'F');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (506, 5, 'actividad_de_convenio', 'G');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (507, 5, 'áreas', 'H');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (508, 5, 'subáreas_de_actividad', 'I');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (509, 5, 'responsable', 'J');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (510, 5, 'corresponsables', 'K');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (511, 5, 'objetivo', 'L');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (512, 5, 'resultado', 'M');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (513, 5, 'poblacion', 'N');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (514, 5, 'observaciones', 'O');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (515, 5, 'creacion', 'P');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (516, 5, 'actualizacion', 'Q');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (401, 40, 'id', 'A');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (402, 40, 'nombre', 'B');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (403, 40, 'fechainicio_localizada', 'C');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (404, 40, 'fechacierre_localizada', 'D');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (405, 40, 'financiador', 'E');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (406, 40, 'monto', 'F');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (407, 40, 'responsable', 'G');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (408, 40, 'equipotrabajo', 'H');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (409, 40, 'compromisos', 'I');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (410, 40, 'observaciones', 'J');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (411, 40, 'fechacreacion_localizada', 'K');
INSERT INTO public.heb412_gen_campoplantillahcm (id, plantillahcm_id, nombrecampo, columna) VALUES (412, 40, 'fechaactualizacion_localizada', 'L');


--
-- Data for Name: heb412_gen_plantillahcr; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.heb412_gen_plantillahcr (id, ruta, fuente, licencia, vista, nombremenu) VALUES (5, 'plantillas/reporte_una_actividad.ods', 'Pasos de Jesús', 'Dominio Público', 'Actividad', 'Reporte de una actividad en hoja de cálculo');

--
-- Data for Name: heb412_gen_campoplantillahcr; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (1, 5, 'id', 'B', 3);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (2, 5, 'fecha', 'G', 3);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (3, 5, 'nombre', 'B', 4);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (4, 5, 'oficina', 'B', 5);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (5, 5, 'lugar', 'G', 5);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (6, 5, 'áreas', 'B', 6);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (7, 5, 'subáreas_de_actividad', 'G', 6);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (8, 5, 'responsable', 'B', 7);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (9, 5, 'corresponsables', 'G', 7);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (10, 5, 'convenio_financiado', 'B', 9);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (11, 5, 'actividad_de_convenio', 'B', 10);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (12, 5, 'objetivo_convenio_financiero', 'G', 10);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (13, 5, 'objetivo', 'B', 11);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (14, 5, 'poblacion_mujeres_l_g1', 'B', 14);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (15, 5, 'poblacion_hombres_l_g1', 'C', 14);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (16, 5, 'poblacion_mujeres_r_g1', 'D', 14);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (17, 5, 'poblacion_hombres_r_g1', 'E', 14);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (18, 5, 'poblacion_mujeres_l_g2', 'B', 15);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (19, 5, 'poblacion_hombres_l_g2', 'C', 15);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (20, 5, 'poblacion_mujeres_r_g2', 'D', 15);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (21, 5, 'poblacion_hombres_r_g2', 'E', 15);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (30, 5, 'poblacion', 'B', 20);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (31, 5, 'resultado', 'B', 23);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (35, 5, 'poblacion_mujeres_l_g5', 'B', 18);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (36, 5, 'poblacion_hombres_l_g5', 'C', 18);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (37, 5, 'poblacion_mujeres_r_g5', 'D', 18);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (38, 5, 'poblacion_hombres_r_g5', 'E', 18);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (39, 5, 'poblacion_mujeres_l_g6', 'B', 19);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (40, 5, 'poblacion_hombres_l_g6', 'C', 19);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (41, 5, 'poblacion_mujeres_r_g6', 'D', 19);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (42, 5, 'poblacion_hombres_r_g6', 'E', 19);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (33, 5, 'creacion', 'B', 24);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (34, 5, 'actualizacion', 'G', 24);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (25, 5, 'poblacion_hombres_r_g3', 'E', 16);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (29, 5, 'poblacion_hombres_r_g4', 'E', 17);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (24, 5, 'poblacion_mujeres_r_g3', 'D', 16);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (28, 5, 'poblacion_mujeres_r_g4', 'D', 17);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (23, 5, 'poblacion_hombres_l_g3', 'C', 16);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (27, 5, 'poblacion_hombres_l_g4', 'C', 17);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (22, 5, 'poblacion_mujeres_l_g3', 'B', 16);
INSERT INTO public.heb412_gen_campoplantillahcr (id, plantillahcr_id, nombrecampo, columna, fila) VALUES (26, 5, 'poblacion_mujeres_l_g4', 'B', 17);


INSERT INTO public.cor1440_gen_tipoindicador (id, nombre, medircon, espcampos, espvaloresomision, espvalidaciones, esptipometa, espfuncionmedir, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at, descd1, descd2, descd3, descd4) VALUES (1, 'CUENTA ACTIVIDADES', 1, NULL, NULL, NULL, 'Numéro de actividades', 'Cuenta actividades', NULL, '2020-03-26', NULL, '2020-03-26', '2020-04-11', NULL, NULL, NULL, NULL);
INSERT INTO public.cor1440_gen_tipoindicador (id, nombre, medircon, espcampos, espvaloresomision, espvalidaciones, esptipometa, espfuncionmedir, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at, descd1, descd2, descd3, descd4) VALUES (2, 'CUENTA POBLACIÓN ACT', 1, NULL, NULL, NULL, 'Número de personas rep.', 'Suma personas contadas en tablas de población de las actividades. Pueden haber repetidas.', NULL, '2020-03-26', NULL, '2020-03-26', '2020-04-11', 'Hombres', 'Mujeres', 'Sin Sexo de Nacimiento', NULL);
INSERT INTO public.cor1440_gen_tipoindicador (id, nombre, medircon, espcampos, espvaloresomision, espvalidaciones, esptipometa, espfuncionmedir, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at, descd1, descd2, descd3, descd4) VALUES (3, 'CUENTA ASISTENTES ACT', 1, NULL, NULL, NULL, 'Número de personas rep.', 'Cuenta personas en listados de asistencia de actividades. Pueden haber repetidas', NULL, '2020-03-26', NULL, '2020-03-26', '2020-04-11', 'Hombres', 'Mujeres', 'Sin Sexo de Nacimiento', NULL);
INSERT INTO public.cor1440_gen_tipoindicador (id, nombre, medircon, espcampos, espvaloresomision, espvalidaciones, esptipometa, espfuncionmedir, observaciones, fechacreacion, fechadeshabilitacion, created_at, updated_at, descd1, descd2, descd3, descd4) VALUES (4, 'CUENTA ASIST. ÚNICOS ACT', 1, NULL, NULL, NULL, 'Número de personas únicas', 'Cuenta personas únicas en listados de asistencia de actividades. Un participante que esté en listado de dos o más actividades actividades diferentes cuenta una sóla vez.', NULL, '2020-03-30', NULL, '2020-03-30', '2020-04-11', 'Hombres', 'Mujeres', 'Sin Sexo de Nacimiento', '');

SELECT pg_catalog.setval('public.cor1440_gen_tipoindicador_id_seq', 101, true);


INSERT INTO public.cor1440_gen_datointermedioti (id, nombre, tipoindicador_id) VALUES (1, 'Mujeres', 2);
INSERT INTO public.cor1440_gen_datointermedioti (id, nombre, tipoindicador_id) VALUES (2, 'Hombres', 2);
INSERT INTO public.cor1440_gen_datointermedioti (id, nombre, tipoindicador_id) VALUES (3, 'Sin Sexo de Nacimiento', 2);
INSERT INTO public.cor1440_gen_datointermedioti (id, nombre, tipoindicador_id) VALUES (4, 'Mujeres', 3);
INSERT INTO public.cor1440_gen_datointermedioti (id, nombre, tipoindicador_id) VALUES (5, 'Hombres', 3);
INSERT INTO public.cor1440_gen_datointermedioti (id, nombre, tipoindicador_id) VALUES (6, 'Sin Sexo de Nacimiento', 3);
INSERT INTO public.cor1440_gen_datointermedioti (id, nombre, tipoindicador_id) VALUES (7, 'Mujeres', 4);
INSERT INTO public.cor1440_gen_datointermedioti (id, nombre, tipoindicador_id) VALUES (8, 'Hombres', 4);
INSERT INTO public.cor1440_gen_datointermedioti (id, nombre, tipoindicador_id) VALUES (9, 'Sin Sexo de Nacimiento', 4);


SELECT pg_catalog.setval('public.cor1440_gen_datointermedioti_id_seq', 101, true);
