
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

    function mc_memory_f( mc_measure_path )

        % Import measures %
        mc_meas = load( mc_measure_path );

        % Create linear system vectors %
        mc_n = mc_meas(:,1);
        mc_c = mc_meas(:,2);
        mc_m = mc_meas(:,3) / 1024;

        % Estimate model parameter %
        mc_p = ( mc_n .* mc_c ) \ mc_m;

        % Display parameter %
        printf( 'Estimated parameter : %f\n', mc_p );

        % Create mapping axis %
        mc_x = linspace( min( mc_n ), max( mc_n ), max( mc_n ) - min( mc_n ) );
        mc_y = linspace( min( mc_c ), max( mc_c ), max( mc_c ) - min( mc_c ) );

        % Create mapping %
        for mc_xx = 1 : length( mc_x ); for mc_yy = 1 : length( mc_y )

                % Create function %
                mc_f( mc_xx, mc_yy ) = mc_p * ( mc_x( mc_xx ) .* mc_y( mc_yy ) );

        end; end

        % Plot configuration %
        figure
        hold on;
        grid on;
        box  on;

        % Display measure points %
        stem3( mc_n, mc_c, mc_m, 'ko', 'Filled', 'LineWidth', 2, 'LineStyle',':', 'MarkerFaceColor','k', 'MarkerEdgeColor','w' );

        % Display model %
        surf( mc_x, mc_y, mc_f', 'EdgeColor', 'None', 'FaceColor', 'Interp' ); colormap( summer );

        % Set viewport %
        view( [ 180 + 45, 25 ] );

        % Axis labels %
        xlabel( 'Threads' );
        ylabel( 'Captures' );
        zlabel( 'Memory [Go]' );

        % Define plot export parameters %
        set( gcf, 'PaperUnits', 'centimeters' );
        set( gcf, 'PaperSize', [20 10] );
        set( gcf, 'PaperPositionMode', 'manual' );
        set( gcf, 'PaperPosition', [0 0 20 10] );

        % Export plot in color EPS format %
        print( '-depsc', '-F:12', [ '../dev/plots/mc_memory_f.eps' ] );

    end
