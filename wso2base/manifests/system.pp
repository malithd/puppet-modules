#----------------------------------------------------------------------------
#  Copyright 2005-2013 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
#----------------------------------------------------------------------------
#
# Class to manage system configuration

class wso2base::system (
  $packages,
  $wso2_group,
  $wso2_user
) {
  # Install system packages
  package { $packages: ensure => installed }

  cron { 'ntpdate':
    command           => "/usr/sbin/ntpdate pool.ntp.org",
    user              => 'root',
    minute            => '*/50'
  }

  group { $wso2_group:
    ensure            => 'present',
    gid               => '502',
  }

  user { $wso2_user:
    password          => $wso2_user,
    gid               => $wso2_group,
    ensure            => present,
    managehome        => true,
    shell             => '/bin/bash',
    require           => Group[$wso2_group]
  }
}
