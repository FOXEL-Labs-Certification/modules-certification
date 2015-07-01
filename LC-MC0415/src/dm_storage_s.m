
    % FOXEL Labs - Data models - Laboratory of Certification
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

    function dm_storage_s( dm_measure_path )

        % Import measures %
        dm_meas = load( dm_measure_path );

        % Create linear system vectors %
        dm_n = dm_meas(:,1);
        dm_s = ( dm_meas(:,2) + dm_meas(:,3) ) / 1024 / 1024;

        % Estimate model parameter %
        dm_p = dm_n \ dm_s;

        % Display parameter %
        printf( 'Estimated parameter : %f\n', dm_p );

        % Plot configuration %
        figure
        hold on;
        grid on;
        box  on;

        % Display measure points %
        stem( dm_n, dm_s, 'ko', 'Filled', 'LineWidth', 2, 'LineStyle', ':', 'MarkerFaceColor','k', 'MarkerEdgeColor','w' );

        % Display model %
        plot( [ min(dm_n), max(dm_n) ], [ min(dm_n), max(dm_n) ] * dm_p, '-r', 'LineWidth', 2 );

        % Axis labels %
        xlabel( 'Captures' );
        ylabel( 'Storage cost [Go]' );

        % Define plot export parameters %
        set( gcf, 'PaperUnits', 'centimeters' );
        set( gcf, 'PaperSize', [20 10] );
        set( gcf, 'PaperPositionMode', 'manual' );
        set( gcf, 'PaperPosition', [0 0 20 10] );

        % Export plot in color EPS format %
        print( '-depsc', '-F:12', [ '../dev/plots/storage_s.eps' ] );

    end
