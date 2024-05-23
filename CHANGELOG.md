# `rexical` Changelog

## 1.0.8 / 2024-05-23

### Dependencies

* Added `getoptlong` as an explicit dependency since Ruby 3.4 removes it from the standard library.


## 1.0.7 / 2019-08-06

### Security

* prefer File.open to Kernel.open


## 1.0.6

### Bug fixes

* scanner states work better.  Thanks Mat.


## 1.0.5

### Bug fixes

* Scanners with nested classes work better


## 1.0.4

### Bug fixes

* Generated tokenizer only tokenizes on pulls


## 1.0.3

### Bug fixes

* renamed to "Rexical" because someone already has "rex".


## 1.0.2

### Bug fixes

* Fixed nested macros so that backslashes will work

