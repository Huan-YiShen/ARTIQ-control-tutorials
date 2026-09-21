# ARTIQ-control-tutorials
A hub to document my work with ARTIQ control systems.

As part of my research, I work closely with an open source software control library / ecosystem called ARTIQ (Advanced Real-Time Infrastructure for Quantum physics). 
You can read what ARTIQ is in this [introductary page](https://m-labs.hk/artiq/manual/introduction.html) on their official manual.
Due to its novelty and the open-sourced nature, it's tools are rapidly evolving and the documentation and tutorial resources are often limited.

The goal of this repository is to document and share my working knowledge of the ARTIQ system. 
The contents will involve tutorials, useful references, and documents similiar to technical white papers. 
I will minimize restating what is avaliable on the [official manual](https://m-labs.hk/artiq/manual/), and reference the official manual whenever possible. At the time of writing, the stable release of the manual is ARTIQ 9.

The target audience is any researcher or student working with the ARTIQ system. Such as, an experimentalist joining a lab that already has ARTIQ integrated into their experiments or an engineering student trying to set up or upgrade the system.

## Where to start

Ultimately, the goal of ARTIQ is to allow you to use this system to control some quantum physics experiment. To do this, you need to understand

- What are you trying to control using ARTIQ --> Ans: Real time hardwares, the *Sinara cards*
- How to program ARTIQ environment to do what you want --> Ans: *ARTIQ-python experiments scripts* 

If you are new to ARTIQ and want to become proficient with this tool, then the [official manual](https://m-labs.hk/artiq/manual/) should be your entry point to gain most of the conceptual background, and the ARTIQ [source code](https://git.m-labs.hk/M-Labs/artiq) should be your source of truth, but I do not recommend diving into the code at the beginning. 
Concretely, the following is an unordered list of concepts that you should aim to deeply understand either through reading tutorials or playing around with the system. You can use this as a check list of verify your current knowledge base and to determine what to learn next.

- Understand basic RTIO concepts, [official tutorial](https://m-labs.hk/artiq/manual/rtio.html)
- Understand what are Sinara cards and "core devices" in ARTIQ, [official tutorial](https://m-labs.hk/artiq/manual/getting_started_core.html)
- Understand how ARTIQ controls & communicates with these "core device"
- Understand what goes into setting up an ARTIQ project [ARTIQ_project_structure](ARTIQ_project_structure/minmum-artiq-project.md)
- Understand the structure of wirting *ARTIQ-python experiments scripts* 
- Understand how to execute scripts with ARTIQ cmd commands [frontend_tools](https://m-labs.hk/artiq/manual/main_frontend_tools.html)
- Understand how to incorperate external devices into ARTIQ with [NDSP](https://m-labs.hk/artiq/manual/developing_a_ndsp.html)




## References
* [manual](https://m-labs.hk/artiq/manual/)
* [manual/introduction](https://m-labs.hk/artiq/manual/introduction.html)
* [source code](https://git.m-labs.hk/M-Labs/artiq)