function [w]=dBm2w(dBm)

w=10^((dBm-30)/10);
