## NAME
   M_graph(3f) - a module for generating a basic XY plot
   (LICENSE:PD)
## SYNOPSIS
```text
       use M_graph, only : graph
```
## DESCRIPTION

## LIST OF PROCEDURES
   + graph ! generate a basic xy plot

## BUILDING THE MODULE USING make(1) ![gmake](docs/images/gnu.gif)
     git clone https://github.com/urbanjost/M_graph.git
     cd M_graph/src
     # change Makefile if not using one of the listed compilers
     
     # for gfortran
     make clean
     make F90=gfortran gfortran
     
     # for ifort
     make clean
     make F90=ifort ifort

     # for nvfortran
     make clean
     make F90=nvfortran nvfortran

This will compile the Fortran module and basic example
program that exercise the routine.

## BUILD and TEST with FPM ![-](docs/images/fpm_logo.gif)

   Alternatively, download the github repository and build it with
   fpm ( as described at [Fortran Package Manager](https://github.com/fortran-lang/fpm) )

   ```bash
        git clone https://github.com/urbanjost/M_graph.git
        cd M_graph
        fpm run
        fpm run --example
        fpm test
   ```

   or just list it as a dependency in your fpm.toml project file.

```toml
        [dependencies]
        M_graph        = { git = "https://github.com/urbanjost/M_graph.git" }
```

## DOCUMENTATION

### USER
![manpages](docs/images/manpages.gif)
   - There are man-pages in the repository download in the docs/ directory
     that may be installed on ULS (Unix-Like Systems).

   + [manpages.zip](https://urbanjost.github.io/M_graph/manpages.zip)
   + [manpages.tgz](https://urbanjost.github.io/M_graph/manpages.tgz)

   - a simple index to the man-pages in HTML form for the
   [routines](https://urbanjost.github.io/M_graph/man3.html) 
   and [programs](https://urbanjost.github.io/M_graph/man1.html) 

   - A single page that uses javascript to combine all the HTML
     descriptions of the man-pages is at 
     [BOOK_M_graph](https://urbanjost.github.io/M_graph/BOOK_M_graph.html).

   - [CHANGELOG](docs/CHANGELOG.md) provides a history of significant changes

### DEVELOPER
   - [ford(1) output](https://urbanjost.github.io/M_graph/fpm-ford/index.html).
   - [doxygen(1) output](https://urbanjost.github.io/M_graph/doxygen_out/html/index.html).
   - [github action status](docs/STATUS.md) 
---
## PEDIGREE
 Based on the public domain library liblong.

## REFERENCES ![-](docs/images/ref.gif)

   * [](https://en.wikipedia.org/wiki/)
---
