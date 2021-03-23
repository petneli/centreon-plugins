#
# Copyright 2021 Centreon (http://www.centreon.com/)
#
# Centreon is a full-fledged industry-strength solution that meets
# the needs in IT infrastructure and application monitoring for
# service performance.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

package cloud::azure::web::appservice::plugin;

use strict;
use warnings;
use base qw(centreon::plugins::script_custom);

sub new {
    my ($class, %options) = @_;
    my $self = $class->SUPER::new( package => __PACKAGE__, %options );
    bless $self, $class;

    $self->{version} = '0.1';
    $self->{modes} = {
        'data'              => 'cloud::azure::web::appservice::mode::data',
        'health'            => 'cloud::azure::web::appservice::mode::health',
        'memory'            => 'cloud::azure::web::appservice::mode::memory',
        'status'            => 'cloud::azure::web::appservice::mode::status',
        'cpu-time'          => 'cloud::azure::web::appservice::mode::cputime',
        'gc-usage'          => 'cloud::azure::web::appservice::mode::gcusage',
        'app-usage'         => 'cloud::azure::web::appservice::mode::appusage',
        'discovery'         => 'cloud::azure::web::appservice::mode::discovery',
        'io-operations'     => 'cloud::azure::web::appservice::mode::iooperations',
        'http-requests'     => 'cloud::azure::web::appservice::mode::httprequests',
        'response-time'     => 'cloud::azure::web::appservice::mode::responsetime',
        'filesystem-usage'  => 'cloud::azure::web::appservice::mode::filesystem'
    };

    $self->{custom_modes}->{azcli} = 'cloud::azure::custom::azcli';
    $self->{custom_modes}->{api} = 'cloud::azure::custom::api';
    return $self;
}

sub init {
    my ($self, %options) = @_;

    $self->{options}->add_options(arguments => {
        'api-version:s'  => { name => 'api_version', default => '2018-01-01' }
    });

    $self->SUPER::init(%options);
}

1;

__END__

=head1 PLUGIN DESCRIPTION

Check Microsoft Azure App Service.

=cut
