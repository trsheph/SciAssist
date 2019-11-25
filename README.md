# SciAssist
Automated Scientific Assistant

This is a scientific project manager, data repository, and automated report writer that compiles the data into materials and methods and results sections. A postgres database linked to json files houses lab-specific protocols, equipment, reagents, experiments, and tagged raw data files with immutable dates to allow for data organization. Using the automated report writer, these data are compiled into English text grant, manuscript, or report files to ease writing workflows.

The front end for the interactions take place with Electron, while the backend of the processing takes place in Python, Postgres, and ImageJ.
