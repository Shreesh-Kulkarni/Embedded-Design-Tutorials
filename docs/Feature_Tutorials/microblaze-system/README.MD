<p align="right"><a href="../../docs-cn/README.md">简体中文</a> | <a href="../../docs-jp/README.md">日本語</a></p>
<table width="100%">
  <tr width="100%">
    <td align="center"><img src="https://raw.githubusercontent.com/Xilinx/Image-Collateral/main/xilinx-logo.png
" width="30%"/><h1>Programming an Embedded MicroBlaze Processor</h1>
    </td>
 </tr>
 </table>

 # Introduction

 In this tutorial, you create a simple MicroBlaze™ system for a Spartan®-7 FPGA using Vivado® IP integrator.

 The MicroBlaze system includes native Xilinx® IP including:

-   MicroBlaze processor

-   AXI block RAM

-   Double Data Rate 3 (DDR3) memory

-   UARTLite

-   AXI GPIO

-   MicroBlaze Debug Module (MDM)

-   Proc Sys Reset

-   Local memory bus (LMB)



 Parts of the block design are constructed using the Platform Board Flow feature. 
 
 This lab also shows the cross-trigger capability of the MicroBlaze processor.

 The feature is demonstrated using a software application code developed in the Vitis software platform in a stand-alone application mode.

 This lab targets the Xilinx SP701 FPGA Evaluation Kit.



# Step 1: Start the Vivado IDE and Create a Project

1.  Start the Vivado IDE by clicking the Vivado desktop icon or by typing ```vivado``` at a command prompt.

2.  From the Quick Start page, select **Create Project**.

3.  In the New Project dialog box, use the following settings:

    1.  In the Project Name dialog box, type the project name and location.

    2.  Make sure that the **Create project subdirectory** check box is selected. Click **Next**.

    3.  In the Project Type dialog box, select **RTL project**. Ensure that the **Do not specify sources at this time** check box is cleared. Click **Next**.

    4.  In the Add Sources dialog box, set the Target language to either **VHDL** or **Verilog**. You can leave the Simulator language selection to **Mixed**.

    5. Click **Next**.

    6. In Add Constraints dialog box, click **Next**.

    7.  In the Default Part dialog box, select **Boards** and choose **Spartan-7 SP701 Evaluation Platform**. Click **Next**.

    8.  Review the project summary in the New Project Summary dialog box and click **Finish** to create the project.

Because you selected the SP701 board when you created the Vivado IDE project, you see the following message in the Tcl Console:

```tcl
set_property board_part xilinx.com:sp701:part0:1.1 [current_project]
```
Although Tcl commands are available for many of the actions performed in the Vivado IDE, they are not explained in this tutorial. Instead, a Tcl script is provided that can be used to recreate this entire project. See the Tcl Console for more information. You can also refer to the *Vivado Design Suite Tcl Command Reference Guide*([UG835](https://www.xilinx.com/cgi-bin/docs/rdoc?v=2021.2%3Bd%3Dug835-vivado-tcl-commands.pdf)) for information about the ```write_bd_tcl``` commands.

# Step 2: Create an IP Integrator Design

1.  From Flow Navigator, under IP integrator, select **Create Block Design**.

2.  Specify the IP subsystem design name. For this step, you can use ```mb_subsystem``` as the Design name. Leave the Directory field set to its default value of \<Local to Project\>. Leave the Specify source set drop-down list set to its default value of Design Sources.

3.  Click **OK** in the Create Block Design dialog box, shown in the following figure.
<img src="./media/image1-1.png"/>

4.  In the IP integrator diagram area, right-click and select **Add IP**. 

    The IP integrator Catalog opens. Alternatively, you can also select the Add IP icon in the middle of the canvas.

    <img src="./media/image2-1.png"  />

5.  Type ```mig``` in the Search field to find the MIG core, then select **Memory Interface Generator (MIG 7 Series)**, and press **Enter**.
    
    <img src="./media/image3-1.png" />

    The Designer Assistance link becomes active in the block design banner.


6.  Click **Run Block Automation**.
<img src="./media/image4-1.png" />
    The Run Block Automation dialog box opens.
    <img src="./media/image5-1.png" />

7.  Click **OK**. This instantiates the MIG core and connects the I/O interfaces to the I/O interfaces for the DDR memory on the SP701 board.
    <img src="./media/image6-1.png"/>

8.  Right-click anywhere in the block design canvas, and select **Add IP**. The IP catalog opens.

9.  In the Search field, type ```micr``` to find the MicroBlaze IP, then select **MicroBlaze**, and press **Enter**.

> ***Note*:** If not displayed by default, the IP Details window can be displayed by clicking **CTRL+Q** on the keyboard while searching for IP.
>
> <img src= "./media/image8-1.png" align="top"/><img src="./media/image7-1.png"/>


## Use the Board Window to Connect to Board Interfaces

There are several ways to use an existing interface in IP integrator. Use the Board window to instantiate some of the interfaces that are present on the SP701 board.

1.  Select the **Board** window to see the interfaces present on the SP701 board.
    
    <img src="./media/image9-1.png"/>


    In the Board window, notice that the DDR3 SDRAM interface is connected as shown by the circle <img src="./media/image10-1.png"/>  in the following figure. This is because you used the Block Automation feature in the previous steps to connect the MIG core to the board interfaces for DDR3 SDRAM memory.

    <img src="./media/image11-1.png"/>

2.  From the Board window, select **UART** under the Miscellaneous folder, and drag and drop it into the block design canvas.

    This instantiates the AXI Uartlite IP on the block design.

3.  Likewise, from the Board window, select **LED** under the General Purpose Input or Output folder, and drag and drop it into the block design canvas.

    This instantiates the GPIO IP on the block design and connects it to the on-board LEDs. 

4.  Next, from the Board window, select **FPGA Reset** under the Reset folder, and drag and drop it into the block design canvas.

    This connects the CPU push button reset to the MIG core IP. 

    The block design now should look like the following figure.
<img src="./media/image12-1.png" />

## Add Peripheral: AXI block RAM Controller


1. Add the AXI block RAM Controller, shown in the following figure, by right-clicking the IP integrator canvas and selecting **Add IP**.

    <img src="./media/image14-1.png" align="top" /><img src="./media/image13-1.png" />

    The block design now should look like the following figure.

    <img src="./media/image14-2.png"/>

## Run Block Automation

1.  Click **Run Block Automation**, as shown below.  
<img src="./media/image15-1.png"/>

The **Run Block Automation** dialog box opens.

2.  On the **Run Block Automation** dialog box:


    1.  Leave Preset as the default value, **None**.

    2.  Set Local Memory to **64 KB**.

    3.  Leave the Local Memory ECC as the default value, **None**.

    4.  Set Cache Configuration to **32 KB**.

    5.  Set Debug Module to **Extended Debug**.

    6.  Leave the Peripheral AXI Port option as the default value, **Enabled**.

    7.  Leave the Interrupt Controller option unchecked.

    8.  Leave The Clock source option set to **/mig_7series_0/ui_addn_clk_0 (100 MHz)**.
<img src="./media/image16-1.png" />

3.  Click **OK**.

    This generates a basic MicroBlaze system in the IP integrator diagram area, as shown in the following figure.

    <img src="./media/image17-1.png"/>

## Use Connection Automation

Run Connection Automation provides several options that you can select to make connections. This section will walk you through the first connection, and then you will use the same procedure to make the rest of the required connections for this tutorial.

1.  Click **Run Connection Automation** as shown in the following figure.
<img src="./media/image18-1.png"/>

The Run Connection Automation dialog box opens.

2.  Check the All Automation check box in the left pane of the dialog box as shown in the following figure. 
    This selects interfaces to run Connection Automation for.
    <img src="./media/image19-1.png"/>

3.  Use the following table to set options in the Run Connection Automation dialog box.

    *Table 1:* **Run Connection Automation Options** 

    <table>
    <colgroup>
    <col style="width: 33%" />
    <col style="width: 33%" />
    <col style="width: 33%" />
    </colgroup>
    <thead>
    <tr class="header">
    <th>
    <p><strong>Connection</strong></p>
    </th>
    <th>
    <p><strong>More Information</strong></p>
    </th>
    <th>
    <p><strong>Configuration</strong></p>
    </th>
    </tr>
    </thead>
    <tbody>
    <tr class="odd">
    <td><p>axi_bram_ctrl_0</p>
    <ul>
    <li><p>BRAM_PORTA</p></li>
    </ul></td>
    <td>The only option for this automation is to instantiate a new Block
    Memory Generator as shown under options.</td>
    <td>Leave the Blk_Mem_Gen option to its default value of Auto.</td>
    </tr>
    <tr class="even">
    <td><p>axi_bram_ctrl_0</p>
    <ul>
    <li><p>BRAM_PORTB</p></li>
    </ul></td>
    <td><p>The Run Connection Automation dialog box opens and gives you two choices:</p>
    <ul>
    <li><p>Instantiate a new BMG and connect the PORTB of the AXI block RAM
    Controller to the new BMG IP</p></li>
    <li><p>Use the previously instantiated BMG core and automatically
    configure it to be a true dual- ported memory and connected to PORTB of
    the AXI block RAM Controller.</p></li>
    </ul></td>
    <td>Leave the Blk_Mem_Gen option to its default value of Auto.</td>
    </tr>
    <tr class="odd">
    <td><p>axi_bram_ctrl_0</p>
    <ul>
    <li><p>S_AXI</p></li>
    </ul></td>
    <td>Two options are presented in this case. The Master field can be set for either cached or non-cached accesses</td>
    <td>The Run Connection Automation dialog box offers to connect this to the /microblaze_0 (Cached). Leave it to its default value. In case, cached accesses are not desired
    this could be changed to /microblaze_0 (Periph).
    <p></p>
    Leave the Clock source (for unconnected clocks) field set to its default value of Auto.
    </td>
    </tr>
    <tr class="even">
    <td><p>axi_gpio_0</p>
    <ul>
    <li><p>S_AXI</p></li>
    </ul></td>
    <td><p>The Master field is set to its default value of /microblaze_0 (Periph).</p>
    <p>The Clock source (for unconnected clocks) field is set to its default value of Auto.</p>
    </td>
    <td>Keep these default settings.</td>
    </tr>
    <tr class="odd">
    <td><p>axi_uartlite_0</p>
    <ul>
    <li><p>S_AXI</p></li>
    </ul></td>
    <td><p>The Master field is set to its default value of /microblaze_0 (Periph).</p>
    <p>The Clock source (for unconnected clocks) field is set to its default value of Auto.</p></td>
    <td>Keep these default settings.</td>
    </tr>
    <tr class="even">
    <td><p>mdm_1</p>
    <ul>
    <li><p>TRIG_IN_0</p></li>
    </ul></td>
    <td>This will be connected to a new System ILA core’s TRIG_OUT pin.</td>
    <td>Leave the ILA Connection settings to its default value of Auto.</td>
    </tr>
    <tr class="odd">
    <td><p>mdm_1</p>
    <ul>
    <li><p>TRIG_OUT_0</p></li>
    </ul></td>
    <td>This will be connected to the System ILA core’s TRIG_IN pin.</td>
    <td>Leave the ILA Connections settings to its default value of
    Auto.</td>
    </tr>
    <tr class="even">
    <td><p>mig_7series_0</p>
    <ul>
    <li><p>S_AXI</p></li>
    </ul></td>
    <td><p>The Master field is set to /microblaze_0 (Cached). Leave it to this value so the accesses to the DDR3 memory are cached accesses. </p>
    <p>The Clock source (for unconnected clocks) field is set to its
    default value of Auto.</p>
    </td>
    <td>Keep these default settings.</td>
    </tr>
    <tr class="odd">
    <td><p>rst_mig_7_series_0_100M</p>
    <ul>
    <li><p>ext_reset_in</p></li>
    </ul></td>
    <td>The reset pin of the Processor Sys Reset IP will be connected to
    the board reset pin.</td>
    <td>Keep the default setting.</td>
    </tr>
    </tbody>
    </table>

4.  After setting the appropriate options, as shown in the table above, click **OK**.

At this point, your IP integrator diagram area should look like the following figure.

<img src="./media/image20-1.png"/>

***Note*:** The relative placement of your IP might be slightly different.

## Mark Nets for Debugging

1.  To monitor the AXI transactions taking place between the MicroBlaze and the GPIO, select the interface net connecting M00_AXI interface pin of the microblaze_0\_axi_periph instance and the S_AXI interface pin of the axi_gpio_0 instance.

2.  Right-click and select **Debug** from the context menu.

> ***Note*:** The Designer Assistance is available as indicated by the Run Connection Automation link in the banner of the block design.

3.  Click **Run Connection Automation**.

4.  In the Run Connection Automation dialog box, go with the default setting as shown in the following figure.
<img src="./media/image21-1.png"/>

5.  Click **OK**.

6.  Click the Regenerate Layout button <img src="./media/image25-1.png" align="bottom"/> in the IP integrator toolbar to generate an optimum layout for the block design. The block diagram should look like the following figure.
<img src="./media/image22-1.png"/>

***Note*:** The relative placement of your IP might be slightly different.

## Add Connection Between MDM and AXI SmartConnect

In order to enable JTAG-based debugging of the AXI BRAM Controller and the DDR3 RAM, a connection between the MicroBlaze Debug Module (MDM) and AXI SmartConnect must be made.

1.  Click **Run Connection Automation**.

2. In the Run Connection Automation dialog box box set the Slave interface option to either **/axi_bram_ctrl_0/S_AXI** or **/mig_7series_0/S_AXI**.
<img src="./media/image24-1.png">

Either option will connect to the same AXI SmartConnect instance allowing for JTAG memory access.

3. Click the Regenerate Layout button <img src="./media/image25-1.png" align="bottom"/> in the IP integrator toolbar to generate an optimum layout for the block design. The block diagram should look like the following figure.
<img src="./media/image26-1.png">
***Note*:** The relative placement of your IP might be slightly different.

This connection connects the AXI4 master port of the MicroBlaze Debug Module (MDM) to the AXI SmartConnect for direct access to memory from JTAG. This allows fast program download, as well as transparent memory access when the connected MicroBlaze processors are executing.


# Step 3: Memory-Mapping the Peripherals in IP Integrator

1.  Click the **Address Editor** window.

2.  In the Address Editor, do the following:

    1.  Expand the microblaze_0 instance by clicking on the Expand All icon <img src="./media/image27-1.png" align="bottom"/> in the toolbar to the top of the Address Editor window.

    2.  Change the range of microblaze_0/mig_7_series_0/memmap IP in both the Data and the Instruction section to **512 MB**, and mdm_1/mig_7_series_0/memmap also to **512 MB**, as shown in the following figure.
    <img src="./media/image29-1.png"/>

    3. The top of the Address Editor window should show Assigned (11), indicating all 11 interfaces were assigned addresses. If Unassigned shows any interfaces unassigned, click on the **Assign All** arrow <img src="./media/image28-1.png"/>.

You must also ensure that the memory in which you are going to run and store your software is within the cacheable address range. This occurs when you enable Instruction Cache and Data Cache, while running the Block Automation for the MicroBlaze processor.

To use either Memory IP DDR or AXI block RAM, those IP must be in the cacheable area; otherwise, the MicroBlaze processor cannot read from or write to them.

Validating the design will automatically re-configure the MicroBlaze processor’s cacheable address range.

# Step 4: Validate Block Design

To run design rule checks on the design:

1.  Click the Validate Design button on the toolbar, or select **Tools → Validate Design**.
    
The Validate Design dialog box informs you that there are no critical warnings or errors in the design.

2.  Click **OK**.

3.  Save your design by pressing **Ctrl+S**, or select **File → Save Block Design**.

# Step 5: Generate Output Products

1.  In the Sources window, select the block design, then right-click it and select **Generate Output Products**. Alternatively, you can click **Generate Block Design in the Flow Navigator**.

The Generate Output Products dialog box opens.

2.  Click **Generate**.
<img src="./media/image30-1.png"/>

The Generate Output Products dialog box informs you that Out-of-context module runs were launched.

3.  Click **OK**.

4.  Wait a few minutes for all the Out-of-Context module runs to finish as shown in the Design Runs windows.
<img src="./media/image31-1.png"/>

# Step 6: Create a Top-Level Wrapper

1.  Under Design Sources, right-click the block design ```mb_subsystem``` and click **Create HDL Wrapper**.

In the Create HDL Wrapper dialog box, Let Vivado manage wrapper and auto-update is selected by default.

2.  Click **OK**.
<img src="./media/image32-1.png"/>

# Step 7: Take the Design through Implementation

1.  In the Flow Navigator, click **Generate Bitstream**.

The No implementation Results Available dialog box opens.

2.  Click **Yes**.

The Launch Runs dialog box opens.

3.  Make the appropriate choices and click **OK**.

Bitstream generation can take several minutes to complete. Once it finishes, the Bitstream Generation Completed dialog box asks you to select what to do next.  

4.  Keep the default selection of Open Implemented Design and click **OK**.

5.  Verify that all timing constraints have been met by looking at the Timing - Design Timing Summary window, as shown in the following figure.
<img src="./media/image33-1.png"/>

# Step 8: Export the Design to the Vitis software platform

><img src="./media/image29.png" align="left"/>**IMPORTANT!** *For the usb driver to install, you must power on and connect the board to the host PC before launching the Vitis software platform.*

Next, open the design and export to the Vitis software platform.

1.  From the Vivado File menu, select **File → Export → Export Hardware**. The Export Hardware Platform dialog box opens.

2.  Click **Next**.

3.  Select the **Include bitstream** option using the radio button in the Output view and click **Next**.
<img src="./media/image34-1.png"/>

4.  Leave the XSA file name field at its default value and click **Next**. (The following figure shows Windows-specific settings.)
<img src="./media/image35-1.png"/>

5.  Click **Finish**. This will export the hardware XSA File in the lab1 project directory.
<img src="./media/image36-1.png"/>

6.  To launch the Vitis software platform, select **Tools → Launch Vitis IDE**. The Eclipse Launcher dialog box opens.

7.  Specify the desired Workspace location such as C:\Projects\Vitis_Workspaces\microblaze-system (Windows-specific).

8.  Click **Launch**.

# Step 9: Create a "Peripheral Test" Application

The Vitis software platform launches in a separate window.
<img src="./media/image37-1.png"/>

1.  Close the Welcome screen if it appears.

2.  Select **File → New → Application Project** or under **Project** click **Create Application Project**.
<img src="./media/image38-1.png"/>

3.  Select the **Skip welcome page next time** check box if you do not want the welcome to appear when the Vitis software platform is launched again.

4.  Click **Next**.

5.  In the Platform page, select the **Create a new platform from hardware (XSA)** tab.
<img src="./media/image39-1.png"/>

6.  Click **Browse** to open the Create Platform from XSA window. Navigate to the directory where the XSA file was created in Vivado and click **Open**.
<img src="./media/image40-1.png"/>

7.  Click **Next**.

8. In the Application project name field, type the name desired, such as ```peri_test```. Leave all other fields to their default values, and click **Next**.
<img src="./media/image41-1.png"/>

9. In the Domain page leave all the fields at their default values and click **Next**.
<img src="./media/image42-1.png"/>


11. In the Templates page, select **Peripheral Tests**.
<img src="./media/image43-1.png"/>

12. Click **Finish**.

13. A new ```peri_test``` application is created. To build the application click the hammer icon <img src="./media/image44-1.png"/> in the toolbar.

14. Wait for the application to finish compiling.


15. Right-click the peri_test application in the Project Explorer, and select **Generate Linker Script**.

The Generate Linker Script dialog box opens.

16. Select the **Basic** tab, and change the Assigned Memory for Heap and Stack, Code, and Data to DDR memory. Change the Place Code Sections in:, Place Data Sections in: and Place Heap and Stack in: sections to **mig_7series_0_memaddr**. 
<img src="./media/image45-1.png"/>

Setting these values to **mig_7series_0** ensures that the compiled code executes from the DDR3 Memory IP.

17. Click **Generate**.

18. Click **Yes** to overwrite it in the **Linker Already Exists!** dialog box.

19. Click the hammer icon <img src="./media/image44-1.png"/> in the toolbar again to rebuild the application with the modified linker script.

# Step 10: Execute the Software Application on a SP701 Board

><img src="./media/image29.png" align="bottom"/>**IMPORTANT!** *Make sure that you have connected the target board to the host computer and it is turned on.*

1.  Select and right-click the peri_test application in the Project Explorer, and select **Debug As → Debug Configurations**.

The Debug Configurations dialog box opens, as shown in the following figure.

2.  Right-click **Single Application Debug**, and select **New Configuration**.
<img src="./media/image46-1.png"/>

3.  The configurations page opens. Click **Debug**.
<img src="./media/image47-1.png"/>

The Debug perspective window opens.

4.  Set the terminal by selecting the Vitis Terminal tab and clicking the <img src="./media/image48-1.png"/> button.

5.  Use the settings shown in the following figure for the SP701 board and click **OK**.
<img src="./media/image49-1.png"/>

6.  Verify the terminal connection by checking the status at the top of the Vitis software platform Terminal tab, as shown in the following figure.
<img src="./media/image50-1.png"/>

7.  If the ```testperiph.c``` file is not already open, select **../src/testperiph.c**, and double-click to open the source file.

8.  Modify the source file by inserting a while statement at approximately line 41.

    1.  In line 41, add ``` while(1)``` above the curly brace as shown in the following figure.
    <img src="./media/image51-1.png"/>

9.  Add a breakpoint in the code so that the processor stops code execution when the breakpoint is encountered. To do so, scroll down to line 50 and double-click on the left pane, which adds a breakpoint on that line of code, as shown in the following figure.

10. Press **Ctrl + S** to save the file. Alternatively, you can select **File → Save**.
<img src="./media/image52-1.png"/>

11. Click the hammer icon <img src="./media/image44-1.png"/> to rebuild the file with the modified code. Now you are ready to execute the code from the Vitis software platform.

# Step 11: Connect to Vivado Logic Analyzer

Connect to the SP701 board using the Vivado Logic Analyzer.

1.  In the Vivado IDE session, from the Program and Debug drop-down list of the Vivado Flow Navigator, select **Open Hardware Manager**.

2.  In the Hardware Manager window, click **Open target → Open New Target**.
<img src="./media/image53-1.png"/>

The Open New Hardware Target dialog box opens, shown in the following figure.
<img src="./media/image54-1.png"/>

3.  Click **Next**.

4.  On the Hardware Server Settings page, ensure that the Connect to field is set to **Local server (target is on local machine)** as shown in the following figure, and click **Next**.
<img src="./media/image55-1.png"/>

5.  On the Select Hardware Target page, click **Next**.

6.  Ensure that all the settings are correct on the Open Hardware Target Summary dialog box, as shown in the following figure, and click **Finish**.
<img src="./media/image56-1.png"/>

 ***Note*:** You can also use the Auto Connect option to connect to the target hardware.

# Step 12: Set the MicroBlaze to Logic Cross Trigger
When the Vivado Hardware Session successfully connects to the SP701 board, you see the information shown in the following figure:
<img src="./media/image57-1.png" />


1.  Select the **Settings - hw_ila_1** tab and set the Trigger Mode Settings as follows:

    1.  Set Trigger mode to **TRIG_IN_ONLY**.

    2.  Set TRIG_OUT mode to **TRIG_IN_ONLY**.

    3.  Under Capture Mode Settings, ensure that Trigger position in window is set to **512**.
    <img src="./media/image59-1.png" />

2.  Arm the ILA core by clicking the Run Trigger <img src="./media/image58-1.png" align="bottom"/> button.

This arms the ILA. You should see the status “Waiting for Trigger” in the **Status - hw_ila_1** tab as shown in the following figure.

<img src="./media/image60-1.png"/>

3.  In the Vitis software platform Debug window, click **MicroBlaze #0** and then click the **Resume** button.

The code will execute until the breakpoint set on line 50 in ```testperiph.c``` file is reached. As the breakpoint is reached, this triggers the ILA, as shown in the following figure.
<img src="./media/image61-1.png"/>

This demonstrates that when the breakpoint is encountered during code execution, the MicroBlaze triggers the ILA that is set up to trigger. This way you can monitor the state of the hardware at a certain point of code execution.

# Step 13: Set the Logic to Processor Cross- Trigger

Now try the logic to processor side of the cross-trigger mechanism. In other words, remove the breakpoint that you set earlier on line 50 to have the ILA trigger the processor and stop code execution.

1.  Select the **Breakpoints** tab towards the top right corner of the window, and clear the **testperiph.c [line: 50]** check box. This removes the breakpoint that you set up earlier.

Alternatively, you can also right click on the breakpoint in the ```testperiph.c``` file, and select **Disable Breakpoint**.

2.  In the Debug window, right-click the **MicroBlaze #0 target** and select **Resume**. 

The code runs continuously because it has an infinite loop.

You can see the code executing in the Terminal Window in the Vitis software platform.

3.  In Vivado, select the **Settings - hw_ila_1** tab. Change the Trigger Mode to **BASIC_OR_TRIG_IN** and the TRIG_OUT mode to **TRIGGER_OR_TRIG_IN**.

4.  Click on the (+) sign in the Trigger Setup window to add the ```slot_0:microblaze_0_axi_periph_M00:AWVALID``` signal from the Add Probes window.

5.  In the Trigger Setup window, for ```slot_0:microblaze_0_axi_periph_M00:AWVALID``` signal, ensure that the Radix field is set to **[B] (Binary)** and set the Value field to **1 (logical one)**.

This essentially sets up the ILA to trigger when the ```awvalid``` transitions to a value of 1.

6.  Click the Run Trigger button to “arm” the ILA in the Status – hw_ila_1 window.

The ILA immediately triggers as the application software is continuously performing a write to the GPIO thereby toggling the ```net_slot_0\_axi_awvalid``` signal, which causes the ILA to trigger. The ILA in turn, toggles the ```TRIG_OUT``` signal, which signals the processor to stop code execution.

This is seen in Vitis in the highlighted area of the debug window.

<img src="./media/image62-1.png"/>

# Conclusion

In this tutorial, you:

-   Stitched together a design in the Vivado IP integrator

-   Took the design through implementation and bitstream generation

-   Exported the hardware to Vitis

-   Created and modified application code that runs on a Standalone Operating System

-   Modified the linker script so that the code executes from the DDR3 memory

-   Verified cross-trigger functionality between the MicroBlaze processor executing code and the design logic

# Lab Files

The Tcl script ```lab.tcl``` is included with the design files to perform all the tasks in Vivado. The Vitis software platform operations must be done in the Vitis GUI. You will need to modify the Tcl script to match the desired project path and project name on your machine.

---

© Copyright 2017-2022 Xilinx, Inc.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
