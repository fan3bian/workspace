# Copyright 2016 Dell Inc.
# All Rights Reserved.
#
#    Licensed under the Apache License, Version 2.0 (the "License"); you may
#    not use this file except in compliance with the License. You may obtain
#    a copy of the License at
#
#         http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
#    WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
#    License for the specific language governing permissions and limitations
#    under the License.
#
#[]在python里不是数组，是列表List，序列（sequence)一种
_volume_register = []
_backup_register = []
_fczm_register = []
#fczm：fibre channel zone mangager

def volumedriver(cls):
    """Decorator for concrete volume driver implementations."""
    #具体的卷驱动实现的装饰器
    _volume_register.append(cls)
    return cls


def backupdriver(cls):
    """Decorator for concrete backup driver implementations."""
    _backup_register.append(cls)
    return cls


def fczmdriver(cls):
    """Decorator for concrete fibre channel zone manager drivers."""
    ##fibre channel光线通道
    _fczm_register.append(cls)
    return cls
