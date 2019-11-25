CREATE TABLE protocolgroups (
    id BIGSERIAL PRIMARY KEY,
    proGrpName TEXT NOT NULL,
    proGrpDesc TEXT,
    proGrpMembers BIGINT[]
);
INSERT INTO protocolgroups (progrpname, progrpdesc) VALUES ('Cloning', 'DNA cloning strategies, ligation, transformation');
INSERT INTO protocolgroups (progrpname, progrpdesc) VALUES ('Material Production', 'PCR, transcription, translation, phage production, protein production, cell culturing, fermentation');
INSERT INTO protocolgroups (progrpname, progrpdesc) VALUES ('Material Processing', 'Material cleanup, purification, precipitation, chromotography, crystallization');
INSERT INTO protocolgroups (progrpname, progrpdesc) VALUES ('Material Analysis', 'Quantitative PCR, agarose gel, acrylamide gel, dynamic light scattering, nuclear magnetic resonance, structure determination');
INSERT INTO protocolgroups (progrpname, progrpdesc) VALUES ('Experimental Assays', 'Microscopy, fluorescence, dose-response, kinetics, ITC, cellular assays, RT-qPCR, in vitro translation');
CREATE TABLE protocols (
    id BIGSERIAL PRIMARY KEY,
    protName TEXT NOT NULL,
    protDesc TEXT,
    protKeyw TEXT[],
    protGrp BIGINT NOT NULL REFERENCES protocolgroups(id),
    protDate TIMESTAMP NOT NULL,
    protocol json NOT NULL
);
CREATE TABLE projects (
    id BIGSERIAL PRIMARY KEY,
    projName TEXT NOT NULL,
    projDesc TEXT,
    projKeyw TEXT[],
    projCollab TEXT[],
    projDate TIMESTAMP NOT NULL,
    projMembers json NOT NULL
);
CREATE TABLE manufacturers (
  id BIGSERIAL PRIMARY KEY,
  mfgName TEXT NOT NULL,
  mfgAddress TEXT
);
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('NEB', 'Ipswitch, MA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Invitrogen', 'Carlsbad, CA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('VWR', 'Radnor, PA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Qiagen', 'Germantown, MD');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('ThermoFisher', 'Waltham, MA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Bio-Rad', 'Hercules, CA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Zymo', 'Irvine, CA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Horiba', 'Kyoto, Japan');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Tecan', 'Mannedorf, Switzerland');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Lonza', 'Basel, Switzerland');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Sigma', 'St. Louis, MO');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('IDT', 'Coralville, IA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Roche', 'Basel, Switzerland');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Waters', 'Milford, MA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('GE', 'Boston, MA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('MCLAB', 'San Francisco, CA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Trilink', 'San Diego, CA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Genewiz', 'Cambridge, MA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Takara Bio', 'Kusatsu, Japan');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('QuantaBio', 'Beverly, MA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Illumina', 'San Diego, CA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Pacific Bioscience', 'Menlo Park, CA');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('TA Instruments', 'New Castle, DE');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Malvern Panalytical', 'Cambridge, United Kingdom');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('New Brunswick Scientific','Edison, NJ');
INSERT INTO manufacturers (mfgname, mfgaddress) VALUES ('Promega', 'Madison, WI');
CREATE TABLE materialgroups (
  id BIGSERIAL PRIMARY KEY,
  matGrpName TEXT NOT NULL,
  matGrpDesc TEXT,
  matGrpMembers BIGINT[]
);
INSERT INTO materialgroups (matgrpname, matgrpdesc) VALUES ('chemicals', 'small molecules, chemicals');
INSERT INTO materialgroups (matgrpname, matgrpdesc) VALUES ('disposables', 'tubes, needles');
INSERT INTO materialgroups (matgrpname, matgrpdesc) VALUES ('plasmids', 'Plasmids for plasmid stock management');
INSERT INTO materialgroups (matgrpname, matgrpdesc) VALUES ('primers', 'Primers for DNA amplification');
INSERT INTO materialgroups (matgrpname, matgrpdesc) VALUES ('enzymes', 'Purchased enzymes');
INSERT INTO materialgroups (matgrpname, matgrpdesc) VALUES ('proteins', 'Proteins being studied');
INSERT INTO materialgroups (matgrpname, matgrpdesc) VALUES ('equipment', 'Equipment of note');
INSERT INTO materialgroups (matgrpname, matgrpdesc) VALUES ('compositions', 'Mixes of reagents where the sum is greater than the parts - agarose gel for example');
INSERT INTO materialgroups (matgrpname, matgrpdesc) VALUES ('kits', 'Ready-made kits');
CREATE TABLE chemicals (
  id BIGSERIAL PRIMARY KEY,
  chemName TEXT NOT NULL,
  chemDesc TEXT,
  matGrp BIGINT NOT NULL REFERENCES materialgroups(id),
  chemMfg TEXT,
  chemRcvd DATE,
  chemLotNum TEXT,
  chemProdNum TEXT,
  recDate TIMESTAMP,
  creDate DATE,
  expDate DATE,
  externID TEXT,
  quantity TEXT
);
CREATE TABLE disposables (
  id BIGSERIAL PRIMARY KEY,
  matName TEXT NOT NULL,
  matDesc TEXT,
  matGrp BIGINT NOT NULL REFERENCES materialgroups(id),
  matMfg TEXT,
  matRcvd DATE,
  matLotNum TEXT,
  matProdNum TEXT,
  recDate TIMESTAMP,
  creDate DATE,
  expDate DATE,
  externID TEXT,
  quantity TEXT
);
CREATE TABLE plasmids (
  id BIGSERIAL PRIMARY KEY,
  plasmidName TEXT NOT NULL,
  plasmidDesc TEXT,
  matGrp BIGINT NOT NULL REFERENCES materialgroups(id),
  plasmidSeq TEXT,
  recDate TIMESTAMP,
  creDate DATE,
  genbankID TEXT,
  gbFile TEXT,
  plasmidFile BYTEA,
  externID TEXT
);
CREATE TABLE primers (
  id BIGSERIAL PRIMARY KEY,
  primerName TEXT NOT NULL,
  primerDesc TEXT,
  primerSeq TEXT,
  primerKeyw TEXT[],
  primPlasmid BIGINT REFERENCES plasmids(id),
  matGrp BIGINT NOT NULL REFERENCES materialgroups(id),
  primerRcvd DATE,
  primerMfg BIGINT REFERENCES manufacturers(id),
  primerMfgID TEXT,
  recDate TIMESTAMP,
  creDate DATE,
  expDate DATE,
  externID TEXT,
  quantity TEXT
);
CREATE TABLE enzymes (
  id BIGSERIAL PRIMARY KEY,
  enzymeName TEXT NOT NULL,
  enzymeDesc TEXT,
  enzymeSite TEXT,
  enzymeUse TEXT,
  enzymeType TEXT,
  enzymeBuffer TEXT,
  enzymeLot TEXT,
  matGrp BIGINT NOT NULL REFERENCES materialgroups(id),
  mfgID BIGINT REFERENCES manufacturers(id),
  mfgProdID TEXT,
  enzymeRcvd DATE,
  recDate TIMESTAMP,
  creDate DATE,
  expDate DATE,
  externID TEXT,
  quantity TEXT
);
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('EcoRI-HF', 'G^AATT_C', 'BioBrick cloning', 'restriction', 'CutSmart', 5, 1,'R3101S', now(), '10,000 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('PstI-HF', 'C_TGCA^G', 'BioBrick cloning', 'restriction', 'CutSmart', 5, 1,'R3140S', now(), '10,000 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('XbaI', 'T^CTAG_A', 'BioBrick cloning', 'restriction', 'CutSmart', 5, 1,'R0145S', now(), '3,000 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('SpeI-HF', 'A^CTAG_T', 'BioBrick cloning', 'restriction', 'CutSmart', 5, 1,'R3133S', now(), '500 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('XhoI', 'C^TGCA_G', 'BglBrick cloning', 'restriction', 'CutSmart', 5, 1,'R0146S', now(), '5,000 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('BglII', 'A^GATC_T', 'BglBrick cloning', 'restriction', 'NEBuffer 3.1', 5, 1,'R0144S', now(), '2,000 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('BamHI-HF', 'G^GATC_C', 'BglBrick cloning', 'restriction', 'CutSmart', 5, 1,'R3136S', now(), '10,000 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('NotI-HF', 'GC^GGCC_GC', 'BioBrick cloning', 'restriction', 'CutSmart', 5, 1,'R3189S', now(), '500 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('NdeI-HF', 'CA^TA_TG', 'Forster cistron', 'restriction', 'CutSmart', 5, 1,'R0111S', now(), '4,000 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('BbsI-HF', 'GAAGACNN^NNNN_N', 'GoldenGate cloning', 'restriction', 'CutSmart', 5, 1,'R3539S', now(), '300 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('BsaI-HF', 'GGTCTCN^NNNN_N', 'GoldenGate cloning', 'restriction', 'CutSmart', 5, 1,'R3733S', now(), '1,000 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('MlyI', 'GAGTCNNNNN^_N', 'MoClo cloning', 'restriction', 'CutSmart', 5, 1,'R0610S', now(), '1,000 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('BsmBI-HF', 'CGTCTCN^NNNN_N', 'GoldenGate', 'restriction', 'CutSmart cloning', 5, 1,'R0580S', now(), '200 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('BtgZI-HF', 'GCGATGNNNNNNNNNN^NNNN_N', 'TypeIIS cloning', 'restriction', 'CutSmart', 5, 1,'R0703S', now(), '100 U');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('FastDigest EcoRI', 'G^AATT_C', 'BioBrick cloning', 'restriction', 'FD green', 5, 5,'FD0275', now(), '2,500 rxn');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('FastDigest PstI', 'C_TGCA^G', 'BioBrick cloning', 'restriction', 'FD green', 5, 5,'FD0615', now(), '2,500 rxn');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('FastDigest XbaI', 'T^CTAG_A', 'BioBrick cloning', 'restriction', 'FD green', 5, 5,'FD0685', now(), '750 rxn');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('FastDigest BcuI', 'A^CTAG_T', 'BioBrick cloning', 'restriction', 'FD green', 5, 5,'FD1254', now(), '50 rxn');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('FastDigest XhoI', 'C^TGCA_G', 'BglBrick cloning', 'restriction', 'FD green', 5, 5,'FD0694', now(), '400 rxn');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('FastDigest BglII', 'A^GATC_T', 'BglBrick cloning', 'restriction', 'FD green', 5, 5,'FD0084', now(), '200 rxn');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('FastDigest BamHI', 'G^GATC_C', 'BglBrick cloning', 'restriction', 'FD green', 5, 5,'FD0054', now(), '800 rxn');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('FastDigest NotI', 'GC^GGCC_GC', 'BioBrick cloning', 'restriction', 'FD green', 5, 5,'FD0596', now(), '250 rxn');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('FastDigest NdeI', 'CA^TA_TG', 'Forster cistron', 'restriction', 'FD green', 5, 5,'FD0585', now(), '1,000 rxn');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('FastDigest BpiI', 'GAAGACNN^NNNN_N', 'GoldenGate cloning', 'restriction', 'FD green', 5, 5,'FD1014', now(), '20 rxn');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('FastDigest Eco31I', 'GGTCTCN^NNNN_N', 'GoldenGate cloning', 'restriction', 'FD green', 5, 5,'FD0294', now(), '100 rxn');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('FastDigest MlyI', 'GAGTCNNNNN^_N', 'MoClo cloning', 'restriction', 'FD green', 5, 5,'ER1371', now(), '1,000 rxn');
INSERT INTO enzymes (enzymename, enzymesite, enzymeuse, enzymetype, enzymebuffer, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('FastDigest Esp3I', 'CGTCTCN^NNNN_N', 'GoldenGate cloning', 'restriction', 'FD green', 5, 5,'FD0454', now(), '20 rxn');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Hi-T4 DNA Ligase', 'Ligation', 'DNA ligase', 5, 1, 'M2622S', now(), '20,000 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Phusion Hotstart DNA polymerase', 'PCR', 'DNA polymerase', 5, 1,'M0535S', now(), '100 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Q5 Hot Start High-Fidelity DNA Polymerase', 'PCR', 'DNA polymerase', 5, 1, 'M0493S', now(), '100 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('AccuStart HiFi polymerase', 'aPCR', 'DNA polymerase', 5, 20, '95085-05K', now(), '5,000 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('LA Taq', 'aPCR', 'DNA polymerase', 5, 19, 'RR002M', now(), '250 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('T7 RNA polymerase', 'Transcription', 'RNA polymerase', 5, 16, 'RP-200', now(), '100,000 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('EnGen Spy dCas9 (SNAP-tag)', 'Gene editing', 'CRISPR', 5, 1, 'M0652T', now(), '400 pmol');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Hi-Fi2 Cas9 3NLS', 'Gene editing', 'CRISPR', 5, 16, 'HF2CAS9-200', now(), '1 nmol');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Phi29 DNA Polymerase', 'DNA replication', 'DNA polymerase', 5, 16, 'PP-200', now(), '5,000 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('T4 polynucleotide kinase', 'Phosphorylation', 'Kinase', 5, 1, 'M0201S', now(), '500 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Shrimp alkaline phosphatase', 'Dephosphorylation', 'Phosphatase', 5, 1, 'M0371S', now(), '500 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('DNase I', 'DNA degradation', 'DNase', 5, 1, 'M0303S', now(), '1,000 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Exonuclease I', 'DNA degradation', 'DNase', 5, 1, 'M0293S', now(), '3,000 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Exonuclease III', 'DNA degradation', 'DNase', 5, 1, 'M0206S', now(), '5,000 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('RecBCD', 'DNA degradation', 'DNase', 5, 1, 'M0345S', now(), '1,000 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('RNase A', 'RNA degradation', 'RNase', 5, 1, 'EN0531', now(), '10 mg/ml');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('RNase H', 'RNA degradation', 'RNase', 5, 1, 'M0297S', now(), '250 U');
INSERT INTO enzymes (enzymename, enzymeuse, enzymetype, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('RNase T1', 'RNA degradation', 'RNase', 5, 1, 'EN0541', now(), '1,000 U/ul');
CREATE TABLE proteins (
  id BIGSERIAL PRIMARY KEY,
  proteinName TEXT NOT NULL,
  proteinDesc TEXT,
  matGrp BIGINT NOT NULL REFERENCES materialgroups(id),
  recDate TIMESTAMP,
  creDate DATE,
  expDate DATE,
  transfDate DATE,
  externID TEXT,
  quantity TEXT
);
CREATE TABLE equipment (
  id BIGSERIAL PRIMARY KEY,
  equipName TEXT NOT NULL,
  equipAltName  TEXT,
  equipDesc TEXT,
  matGrp BIGINT NOT NULL REFERENCES materialgroups(id),
  mfgID BIGINT REFERENCES manufacturers(id),
  mfgProdID TEXT,
  equipRcvd DATE,
  recDate TIMESTAMP,
  externID TEXT
);
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('T100 Thermal Cycler','T100','Bio-Rad T100 thermal cycler', 7, 6, '1861096', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('QuantStudio 6','QS6','ThermoFisher QuantStudio 6 real-time PCR detection system', 7, 5, '4485694', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('QuantStudio 7','QS7','ThermoFisher QuantStudio 7 real-time PCR detection system', 7, 5, '4485701', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('LightCycler 480 II','LightCycler','Roche LightCycler 480 Instrument II real-time PCR detection system', 7, 13, '05015243001', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('CFX384 Touch','CFX384','Bio-Rad CFX384 Touch real-time PCR detection system', 7, 6, '', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('FluoroLog 3','','Horiba fluorometer', 7, 8, '', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('FluoroMax 4','','Horiba fluorometer', 7, 8, '', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('AKTA PURE','AKTA','GE AKTA Pure FPLC', 7, 15, '29018224', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('NGC Quest 10','NGC Quest','Bio-Rad NGC Quest 10 FPLC', 7, 6, '7880001', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('Agarose gel electrophoresis chamber','','Bio-Rad Mini-Sub Cell GT Horizontal Electrophoresis System', 7, 6, '1704406', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('PAGE electrophoresis chamber','','Bio-Rad Mini-PROTEAN Tetra Vertical Electrophoresis Cell', 7, 6, '1658004', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('Gel Doc XR','Gel Doc','Bio-Rad Molecular Imager Gel Doc XR System', 7, 6, '1708195', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('Nano ITC','ITC','TA Instruments Isothermal Titration Calorimetry system', 7, 23, '', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('Zetasizer Nano ZSP','DLS','Malvern zeta potential and dynamic light scattering system', 7, 24, '', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('Innova 26 Incubator','Incubator shaker','New Brunswick Scientific Innova 26 refridgerated incubator shaker', 7, 25, '1220G56', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('MiniSeq','MiniSeq','Illumina MiniSeq sequencer', 7, 21, 'SY-420-1001', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('MiSeq','MiSeq','Illumina MiSeq sequencer', 7, 21, 'SY-410-1003', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('Sequel II','','PacBio Sequel II sequencer', 7, 22, '', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('NanoDrop 2000','NanoDrop','ThermoFisher Nanodrop 2000 spectrophotometer', 7, 5, 'ND-2000', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('Qubit 4','Qubit','Qubit 4 fluorometer', 7, 5, 'Q33238', now());
INSERT INTO equipment (equipname, equipaltname, equipdesc, matgrp, mfgid, mfgprodid, recdate) VALUES ('Evolution 220','UV-Vis','ThermoFisher Evolution 220 UV-Vis spectrophotometer', 7, 5, '840-210600', now());
CREATE TABLE compositions (
  id BIGSERIAL PRIMARY KEY,
  plasmidName TEXT NOT NULL,
  plasmidDesc TEXT,
  matGrp BIGINT NOT NULL REFERENCES materialsgroups(id),
  recDate TIMESTAMP,
  creDate DATE,
  expDate DATE,
  externID TEXT,
  quantity TEXT
);
CREATE TABLE kits (
  id BIGSERIAL PRIMARY KEY,
  kitName TEXT NOT NULL,
  kitAltName  TEXT,
  kitDesc TEXT,
  matGrp BIGINT NOT NULL REFERENCES materialgroups(id),
  mfgID BIGINT REFERENCES manufacturers(id),
  mfgProdID TEXT,
  kitRcvd DATE,
  recDate TIMESTAMP,
  quantity TEXT,
  externID TEXT
);
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('QIAprep DNA miniprep','Miniprep spin kit','Qiagen QIAprep Spin Miniprep Kit', 9, 4, '27106', now(), '250');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Midi kit','Midiprep','Qiagen HiSpeed Plasmid Midi Kit', 9, 4, '12643', now(), '25');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Maxi kit','Maxiprep','Qiagen EndoFree Plasmid Maxi kit', 9, 4, '12362', now(), '10');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Giga Kit','Gigaprep','Qiagen EndoFree Plasmid Giga kit', 9, 4, '12391', now(), '5');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Puregene Kit','Genomic DNA purification kit','Qiagen Gentra Puregene Yeast/Bact. Kit', 9, 4, '', now(), '200 ml');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Zymoclean gel extraction kit','Agarose band extraction kit','Zymo Zymoclean Gel DNA Recovery Kit', 9, 7, 'D4008', now(), '200');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('PureLink RNA miniprep','PureLink RNA cleanup','Invitrogen PureLink RNA Mini Kit', 9, 5, '12183018A', now(), '50');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('RNeasy RNA miniprep','RNeasy RNA cleanup','Qiagen RNeasy MinElute Cleanup Kit', 9, 4, '74204', now(), '50');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('PURE translation kit','PURExpress','NEB PURExpress in vitro protein synthesis kit', 9, 1, 'E6800S', now(), '10 rxn');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Cell extract mammalian translation kit','Mammalian cell free translation','Promega Rabbit Reticulocyte Lysate', 9, 26, 'L4960', now(), '30 rxn');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('KAPA HiFi HotStart ReadyMix 2X Master Mix', 'Kapa PCR Master Mix', 'DNA polymerase mix', 9, 13, 'KK2602', now(), '500 rxn');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Phusion Hot Start Flex 2X Master Mix', 'Phusion PCR Master Mix', 'DNA polymerase mix', 9, 1,'M0536S', now(), '100 U');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Q5 Hot Start High-Fidelity 2X Master Mix', 'Q5 PCR Master Mix', 'DNA polymerase mix', 9, 1, 'M0494S', now(), '100 rxn');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('HiScribe T7 kit', 'HiScribe', 'RNA transcription kit', 9, 1, 'E2040S', now(), '50 rxn');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('HiScribe T7 ARCA and tailing', 'Mammalian HiScribe kit', 'NEB HiScribe T7 ARCA mRNA Kit with tailing', 9, 1, 'E2060S', now(), '20 rxn');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('Luna Universal qPCR Master Mix', 'qPCR', 'DNA qPCR mix', 9, 1, 'M3003E', now(), '2,500 rxn');
INSERT INTO kits (kitname, kitaltname, kitdesc, matgrp, mfgid, mfgprodid, recdate, quantity) VALUES ('EnGen Mutation Detection Kit', 'Surveyor detection kit', 'T7EI', 9, 1, 'E3321S', now(), '25 rxn');
CREATE TABLE expgroups (
  id BIGSERIAL PRIMARY KEY,
  expgrpfile BYTEA,
  expgrpdesc TEXT,
  recDate TIMESTAMP,
  expegrpmarkup json
);
CREATE TABLE experiments (
  id BIGSERIAL PRIMARY KEY,
  expFile BYTEA,
  expText TEXT,
  recDate TIMESTAMP,
  expgrpID BIGINT REFERENCES expgroups(id),
  experimentMarkup json
);
CREATE TABLE rawdata (
  id BIGSERIAL PRIMARY KEY,
  rawFile BYTEA,
  rawText TEXT,
  successSwitch BOOLEAN,
  recDate TIMESTAMP,
  creDate TIMESTAMP,
  expID BIGINT REFERENCES experiments(id),
  protocolID BIGINT REFERENCES protocols(id),
  rawMarkup json
);
CREATE TABLE results (
  id BIGSERIAL PRIMARY KEY,
  recDate TIMESTAMP,
  expID BIGINT REFERENCES experiments(id),
  protocolID BIGINT REFERENCES protocols(id),
  resultsMarkup json
);