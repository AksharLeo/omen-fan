#!/bin/bash
sudo cp /etc/omen-fan/silent.toml /etc/omen-fan/config.toml
sudo systemctl restart omen-fan
