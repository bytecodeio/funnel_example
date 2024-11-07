# Creating a Funnel Chart Visualization in Looker

A funnel chart in Looker is a useful visualization for understanding sequential processes, such as prospect stages in a sales pipeline, engagement with a marketing campaign, or visitor movement through a website. This README provides step-by-step instructions for creating a funnel chart visualization in Looker.

## Step 1: Build the Query

1. Open your Looker Explore.
2. Select the appropriate dimensions and measures for your funnel chart.
  - For a vertical funnel chart, use one or more dimensions and one measure.
  - For a horizontal funnel chart, use a single row with multiple measures and column headers.
3. Optionally, apply any necessary filters or sorts to your data.

## Step 2: Select the Funnel Chart Visualization

1. Click on the visualization type dropdown in the Explore.
2. Select the "Funnel" option from the list of available visualizations.

## Step 3: Configure the Funnel Chart Options

1. Click on the "Edit" button next to the visualization to open the visualization options menu.
2. Configure the following options as needed:
  - **Data Bar Options**:
    - Set row and column limits (if applicable).
    - Add table calculations (if needed).
  - **Axes Menu Options**:
    - Label the left and/or right axis.
    - Edit the chart configuration (if needed).
  - **Bars Menu Options**:
    - Choose the bar colors and color palette.
    - Toggle the "Smoothed Bars" option for a stepped funnel chart.
    - Set the chart orientation (automatic, rows, or columns).
    - Adjust the label scale.
  - **Labels Menu Options**:
    - Set the label position (left, inline, right, or hidden).
    - Choose the percent type (largest value or previous bar).
    - Set the percent position (left, inline, right, or hidden).
    - Set the value position (left, inline, right, or hidden).
    - Set a custom color for labels and percentages (if desired).

## Step 4: Save and Use the Funnel Chart

1. Once you have configured the funnel chart to your desired settings, click the "Run" button to generate the visualization.
2. You can now use the funnel chart in your Looker explores, dashboards, or any other applicable context.

## Additional Resources

- Looker Documentation: [Funnel Charts](https://docs.looker.com/data-modeling/explorers/visualizing-data/funnel-chart)
- Looker Community: [Funnel Chart Discussion](https://community.looker.com/tags/funnel-chart)

## Contributing

If you have any suggestions, improvements, or additional examples related to creating funnel charts in Looker, please feel free to contribute by following the standard guidelines:

1. Create a new branch for your feature or bug fix.
2. Make your changes and commit them with descriptive messages.
3. Push your changes.
4. If necessary, submit a pull request, describing the changes you’ve made.
