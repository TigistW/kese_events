import 'package:flutter/material.dart';
import 'package:kese_events/core/utils/utils.dart';

// paddings in percentages
var bottomPadding1 = 0.12375;
var bottomPadding2 = 0.08125;
var bottomPadding3 = 0.06625;
var bottomPadding4 = 0.2425;
var bottomPadding5 = 0.205;

var inbetweenPadding = 0.05;

// Styles
const TextStyle titleTextStyle1 = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: 12,
  letterSpacing: -0.25,
);
const TextStyle titleTextStyle2 = TextStyle(
  fontWeight: FontWeight.w300,
  fontSize: 12,
  letterSpacing: -0.25,
);

const TextStyle smallTextStyle = TextStyle(
    fontWeight: FontWeight.w300,
    fontSize: 14,
    letterSpacing: -0.25,
    color: smallTextColor);

String logo =
  '''<svg width="54" height="32" viewBox="0 0 54 32" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M0 26.825V18.77L6.705 16.97V0.499998H18.45V13.775L41.445 7.565V0.499998H53.19V12.47L35.55 17.24L45.675 25.25H53.46V32H38.7L23.895 20.345L18.45 21.83V32H6.705V25.025L0 26.825Z" fill="#044603"/>
</svg>
''';

String logoName = '''<svg width="273" height="51" viewBox="0 0 273 51" fill="none" xmlns="http://www.w3.org/2000/svg">
<path d="M123.075 36.5467L123.13 36.5739C124.407 37.2815 124.901 38.8736 124.229 40.1527C121.894 44.5751 117.198 47.596 111.802 47.5551C104.277 47.5007 98.1116 41.4318 98.0018 33.9749C97.8782 26.273 104.14 20 111.898 20C116.278 20 120.192 22.0139 122.732 25.1572L117.761 27.8243C116.168 26.2867 113.958 25.3613 111.541 25.4566C107.106 25.6335 103.536 29.2667 103.481 33.6755C103.426 38.3293 107.216 42.1122 111.884 42.1122C115.125 42.1122 117.94 40.3024 119.34 37.6353C120.054 36.3018 121.743 35.8119 123.075 36.5467Z" fill="#342828" fill-opacity="0.44"/>
<path d="M124.27 27.4978C124.888 28.6952 124.448 30.1648 123.254 30.818L120.205 32.4917L112.653 36.642C111.472 37.2952 109.989 36.9686 109.193 35.88L109.165 35.8392C108.218 34.5464 108.63 32.7094 110.058 31.9474L117.775 27.8107L122.746 25.1437C123.322 25.8785 123.83 26.6677 124.27 27.4978Z" fill="#342828" fill-opacity="0.44"/>
<path d="M138.5 41.195L144.8 22.07H151.505L142.28 47H134.63L125.45 22.07H132.2L138.5 41.195ZM178.218 33.995C178.218 34.895 178.158 35.705 178.038 36.425H159.813C159.963 38.225 160.593 39.635 161.703 40.655C162.813 41.675 164.178 42.185 165.798 42.185C168.138 42.185 169.803 41.18 170.793 39.17H177.588C176.868 41.57 175.488 43.55 173.448 45.11C171.408 46.64 168.903 47.405 165.933 47.405C163.533 47.405 161.373 46.88 159.453 45.83C157.563 44.75 156.078 43.235 154.998 41.285C153.948 39.335 153.423 37.085 153.423 34.535C153.423 31.955 153.948 29.69 154.998 27.74C156.048 25.79 157.518 24.29 159.408 23.24C161.298 22.19 163.473 21.665 165.933 21.665C168.303 21.665 170.418 22.175 172.278 23.195C174.168 24.215 175.623 25.67 176.643 27.56C177.693 29.42 178.218 31.565 178.218 33.995ZM171.693 32.195C171.663 30.575 171.078 29.285 169.938 28.325C168.798 27.335 167.403 26.84 165.753 26.84C164.193 26.84 162.873 27.32 161.793 28.28C160.743 29.21 160.098 30.515 159.858 32.195H171.693ZM196.632 21.71C199.602 21.71 202.002 22.655 203.832 24.545C205.662 26.405 206.577 29.015 206.577 32.375V47H200.277V33.23C200.277 31.25 199.782 29.735 198.792 28.685C197.802 27.605 196.452 27.065 194.742 27.065C193.002 27.065 191.622 27.605 190.602 28.685C189.612 29.735 189.117 31.25 189.117 33.23V47H182.817V22.07H189.117V25.175C189.957 24.095 191.022 23.255 192.312 22.655C193.632 22.025 195.072 21.71 196.632 21.71ZM219.903 27.245V39.305C219.903 40.145 220.098 40.76 220.488 41.15C220.908 41.51 221.598 41.69 222.558 41.69H225.483V47H221.523C216.213 47 213.558 44.42 213.558 39.26V27.245H210.588V22.07H213.558V15.905H219.903V22.07H225.483V27.245H219.903ZM239.554 47.405C237.514 47.405 235.684 47.045 234.064 46.325C232.444 45.575 231.154 44.57 230.194 43.31C229.264 42.05 228.754 40.655 228.664 39.125H235.009C235.129 40.085 235.594 40.88 236.404 41.51C237.244 42.14 238.279 42.455 239.509 42.455C240.709 42.455 241.639 42.215 242.299 41.735C242.989 41.255 243.334 40.64 243.334 39.89C243.334 39.08 242.914 38.48 242.074 38.09C241.264 37.67 239.959 37.22 238.159 36.74C236.299 36.29 234.769 35.825 233.569 35.345C232.399 34.865 231.379 34.13 230.509 33.14C229.669 32.15 229.249 30.815 229.249 29.135C229.249 27.755 229.639 26.495 230.419 25.355C231.229 24.215 232.369 23.315 233.839 22.655C235.339 21.995 237.094 21.665 239.104 21.665C242.074 21.665 244.444 22.415 246.214 23.915C247.984 25.385 248.959 27.38 249.139 29.9H243.109C243.019 28.91 242.599 28.13 241.849 27.56C241.129 26.96 240.154 26.66 238.924 26.66C237.784 26.66 236.899 26.87 236.269 27.29C235.669 27.71 235.369 28.295 235.369 29.045C235.369 29.885 235.789 30.53 236.629 30.98C237.469 31.4 238.774 31.835 240.544 32.285C242.344 32.735 243.829 33.2 244.999 33.68C246.169 34.16 247.174 34.91 248.014 35.93C248.884 36.92 249.334 38.24 249.364 39.89C249.364 41.33 248.959 42.62 248.149 43.76C247.369 44.9 246.229 45.8 244.729 46.46C243.259 47.09 241.534 47.405 239.554 47.405Z" fill="#A6A1A1"/>
<path d="M109.239 36.4792L109.292 36.5046C110.527 37.1666 111.005 38.6559 110.354 39.8525C108.098 43.9896 103.558 46.8156 98.3417 46.7774C91.0678 46.7265 85.1079 41.0491 85.0017 34.0733C84.8823 26.8683 90.935 21 98.4346 21C102.669 21 106.452 22.884 108.907 25.8245L104.102 28.3195C102.563 26.8811 100.426 26.0155 98.0895 26.1046C93.8021 26.27 90.351 29.6688 90.2979 33.7932C90.2448 38.1467 93.9083 41.6856 98.4213 41.6856C101.554 41.6856 104.275 39.9925 105.629 37.4975C106.319 36.25 107.952 35.7918 109.239 36.4792Z" fill="#338600"/>
<path d="M110.394 28.014C110.991 29.1342 110.567 30.509 109.412 31.12L106.465 32.6857L99.1647 36.5683C98.0232 37.1793 96.5896 36.8738 95.8197 35.8554L95.7932 35.8172C94.8773 34.6079 95.2755 32.8894 96.656 32.1766L104.116 28.3068L108.921 25.8118C109.478 26.4992 109.969 27.2375 110.394 28.014Z" fill="#338600"/>
<path d="M20.835 47L9.405 33.005V47H3.105V15.59H9.405V29.675L20.835 15.59H28.44L15.48 31.16L28.8 47H20.835ZM56.1189 33.995C56.1189 34.895 56.0589 35.705 55.9389 36.425H37.7139C37.8639 38.225 38.4939 39.635 39.6039 40.655C40.7139 41.675 42.0789 42.185 43.6989 42.185C46.0389 42.185 47.7039 41.18 48.6939 39.17H55.4889C54.7689 41.57 53.3889 43.55 51.3489 45.11C49.3089 46.64 46.8039 47.405 43.8339 47.405C41.4339 47.405 39.2739 46.88 37.3539 45.83C35.4639 44.75 33.9789 43.235 32.8989 41.285C31.8489 39.335 31.3239 37.085 31.3239 34.535C31.3239 31.955 31.8489 29.69 32.8989 27.74C33.9489 25.79 35.4189 24.29 37.3089 23.24C39.1989 22.19 41.3739 21.665 43.8339 21.665C46.2039 21.665 48.3189 22.175 50.1789 23.195C52.0689 24.215 53.5239 25.67 54.5439 27.56C55.5939 29.42 56.1189 31.565 56.1189 33.995ZM49.5939 32.195C49.5639 30.575 48.9789 29.285 47.8389 28.325C46.6989 27.335 45.3039 26.84 43.6539 26.84C42.0939 26.84 40.7739 27.32 39.6939 28.28C38.6439 29.21 37.9989 30.515 37.7589 32.195H49.5939ZM70.2573 47.405C68.2173 47.405 66.3873 47.045 64.7673 46.325C63.1473 45.575 61.8573 44.57 60.8973 43.31C59.9673 42.05 59.4573 40.655 59.3673 39.125H65.7123C65.8323 40.085 66.2973 40.88 67.1073 41.51C67.9473 42.14 68.9823 42.455 70.2123 42.455C71.4123 42.455 72.3423 42.215 73.0023 41.735C73.6923 41.255 74.0373 40.64 74.0373 39.89C74.0373 39.08 73.6173 38.48 72.7773 38.09C71.9673 37.67 70.6623 37.22 68.8623 36.74C67.0023 36.29 65.4723 35.825 64.2723 35.345C63.1023 34.865 62.0823 34.13 61.2123 33.14C60.3723 32.15 59.9523 30.815 59.9523 29.135C59.9523 27.755 60.3423 26.495 61.1223 25.355C61.9323 24.215 63.0723 23.315 64.5423 22.655C66.0423 21.995 67.7973 21.665 69.8073 21.665C72.7773 21.665 75.1473 22.415 76.9173 23.915C78.6873 25.385 79.6623 27.38 79.8423 29.9H73.8123C73.7223 28.91 73.3023 28.13 72.5523 27.56C71.8323 26.96 70.8573 26.66 69.6273 26.66C68.4873 26.66 67.6023 26.87 66.9723 27.29C66.3723 27.71 66.0723 28.295 66.0723 29.045C66.0723 29.885 66.4923 30.53 67.3323 30.98C68.1723 31.4 69.4773 31.835 71.2473 32.285C73.0473 32.735 74.5323 33.2 75.7023 33.68C76.8723 34.16 77.8773 34.91 78.7173 35.93C79.5873 36.92 80.0373 38.24 80.0673 39.89C80.0673 41.33 79.6623 42.62 78.8523 43.76C78.0723 44.9 76.9323 45.8 75.4323 46.46C73.9623 47.09 72.2373 47.405 70.2573 47.405Z" fill="#038400"/>
</svg>
''';