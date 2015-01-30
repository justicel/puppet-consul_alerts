# puppet consul_alerts 

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with consul_alerts](#setup)
    * [What consul_alerts affects](#what-consul_alerts-affects)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

This module can install the wkhtmltox toolkit to your machine. It supports:
 * Debian Wheezy
 * Ubuntu Precise/Trusty
 * CentOS/RHEL 5 or 6

More information about consul-alerts is on their github repo:
https://github.com/AcalephStorage/consul-alerts

## Module Description

This module installs a consul-alerts binary and configures a basic upstart init script for it.
Will keep updated version as you install new versions of the consul-alerts binary.

## Setup

### What wkhtmltox affects

* Installs a version specific version of consul-alerts to your system

## Usage

puppet module install jlondon-consul_alerts

Also supports inclusion in librarian-puppet

Usage of the module is pretty basic and shouldn't need much other than a default run:

    class { 'consul_alerts':
      ensure      => present,
      data_center => 'dc1', 
    }

Note: Make sure you have consul and key/value config for consul-alerts configured before installation!
---  

## Limitations

Only tested to work with Debian wheezy, Ubuntu precise/trusty or centos 5/6.

## Development

Feel free to fork and modify this module.
Please make sure that if you make a useful change to submit a pull request!
Additionally if you do fully fork the project, please do not remove attribution (I only ask this because it has happened before).
