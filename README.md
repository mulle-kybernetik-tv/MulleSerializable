# MulleSerializable


## serializable/nonserialiable

Experiment with `MulleObjCSerialiable` protocolclass that adds property
encoding/decoding by just adding that protocol to a class.

It works! :)

## PROTOCOLCLASS macros

Added some C macros to declare protocolclasses somewhat more easily.
These will move to MulleObjC shortly.





# This project requires mulle-clang 8.0.0 RC2 or better


## How to build

This is a [mulle-sde](https://mulle-sde.github.io/) project.

It has it's own virtual environment, that will be automatically setup for you
once you enter it with:

```
mulle-sde MulleSerializable
```

Now you can let **mulle-sde** fetch the required dependencies and build the 
project for you:

```
mulle-sde craft
```
