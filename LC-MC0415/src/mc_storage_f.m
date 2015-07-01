
    % FOXEL Labs - Laboratory of Certification - Modules certification
    %
    % Copyright (c) 2013-2015 FOXEL SA - http://foxel.ch
    % Please read <http://foxel.ch/license> for more information.
    %
    %
    % Author(s):
    %
    %      Nils Hamel <n.hamel@foxel.ch>
    %
    %
    % This file is part of the FOXEL project <http://foxel.ch>.
    %
    % This program is free software: you can redistribute it and/or modify
    % it under the terms of the GNU Affero General Public License as published by
    % the Free Software Foundation, either version 3 of the License, or
    % (at your option) any later version.
    %
    % This program is distributed in the hope that it will be useful,
    % but WITHOUT ANY WARRANTY; without even the implied warranty of
    % MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    % GNU Affero General Public License for more details.
    %
    % You should have received a copy of the GNU Affero General Public License
    % along with this program.  If not, see <http://www.gnu.org/licenses/>.
    %
    %
    % Additional Terms:
    %
    %      You are required to preserve legal notices and author attributions in
    %      that material or in the Appropriate Legal Notices displayed by works
    %      containing it.
    %
    %      You are required to attribute the work as explained in the "Usage and
    %      Attribution" section of <http://foxel.ch/license>.

    function mc_storage_f( mc_measure_path )

        % Import measures %
        mc_meas = load( mc_measure_path );

        % Create linear system vectors %
        mc_n = mc_meas(:,1);
        mc_s = mc_meas(:,2) / 1024 / 1024;

        % Estimate model parameter %
        mc_p = mc_n \ mc_s;

        % Display parameter %
        printf( 'Estimated parameter : %f\n', mc_p );

        % Plot configuration %
        figure
        hold on;
        grid on;
        box  on;

        % Display measure points %
        stem( mc_n, mc_s, 'ko', 'Filled', 'LineWidth', 2, 'LineStyle', ':', 'MarkerFaceColor','k', 'MarkerEdgeColor','w' );

        % Display model %
        plot( [ min(dm_n), max(dm_n) ], [ min(dm_n), max(dm_n) ] * mc_p, '-r', 'LineWidth', 2 );

        % Axis labels %
        xlabel( 'Captures' );
        ylabel( 'Storage cost [Go]' );

        % Define plot export parameters %
        set( gcf, 'PaperUnits', 'centimeters' );
        set( gcf, 'PaperSize', [20 10] );
        set( gcf, 'PaperPositionMode', 'manual' );
        set( gcf, 'PaperPosition', [0 0 20 10] );

        % Export plot in color EPS format %
        print( '-depsc', '-F:12', [ '../dev/plots/storage_f.eps' ] );

    end
