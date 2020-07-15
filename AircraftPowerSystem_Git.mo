within ;
package AircraftPowerSystem "SimpleDistributionSystemofBoeingAircraft"
  package Records
    package SynchronousMachine
      record SM300kVA "300 kVA SG"
        extends Modelica.Icons.Record;
        extends AircraftPowerSystem.Records.Base.Synch;
      import Modelica.Constants.pi;
      parameter Integer Poles = 2 "Number of Poles";
      parameter Modelica.SIunits.ApparentPower SNominal(start=300E3)
        "Nominal apparent power";
      parameter Modelica.SIunits.Voltage VsNominal(start=200)
        "Nominal stator voltage per phase";
      final parameter Modelica.SIunits.Current IsNominal=SNominal/(3*VsNominal)
        "Nominal stator current per phase";
      final parameter Modelica.SIunits.Impedance ZReference=VsNominal/IsNominal
        "Reference impedance";
      parameter Modelica.SIunits.Frequency fsNominal(start=50)
        "Nominal stator frequency";
      final parameter Modelica.SIunits.AngularVelocity omega=2*pi*fsNominal
        "Nominal angular frequency";
      parameter Modelica.SIunits.Current IeOpenCircuit(start=10)
        "Open circuit excitation current @ nominal voltage and frequency";
      parameter Real effectiveStatorTurns=1 "Effective number of stator turns";
      final parameter Real turnsRatio=sqrt(2)*VsNominal/(omega*Lmd*
          IeOpenCircuit) "Stator current / excitation current";
      parameter Real x0(start=0.15)
        "Stator stray inductance per phase (approximately zero impedance) [pu]";
      parameter Real xd(start=2)
        "Synchronous reactance per phase, d-axis [pu]";
      parameter Real xq(start=1.9)
        "Synchronous reactance per phase, q-axis [pu]";
      parameter Real xdTransient(start=0.245)
        "Transient reactance per phase, d-axis [pu]";
      parameter Real xdSubtransient(start=0.2)
        "Subtransient reactance per phase, d-axis [pu]";
      parameter Real xqSubtransient(start=0.2)
        "Subtransient reactance per phase, q-axis [pu]";
      parameter Modelica.SIunits.Time Ta(start=0.014171268)
        "Armature time constant";
      parameter Modelica.SIunits.Time Td0Transient(start=5)
        "Open circuit field time constant Td0'";
      parameter Modelica.SIunits.Time Td0Subtransient(start=0.031)
        "Open circuit subtransient time constant Td0'', d-axis";
      parameter Modelica.SIunits.Time Tq0Subtransient(start=0.061)
        "Open circuit subtransient time constant Tq0'', q-axis";
      parameter Modelica.SIunits.Temperature TsSpecification(start=293.15)
        "Specification temperature of stator resistance"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TsRef(start=293.15)
        "Reference temperature of stator resistance"
        annotation (Dialog(tab="Material"));
      parameter Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 alpha20s(start=
            0) "Temperature coefficient of stator resistance at 20 degC"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TrSpecification(start=293.15)
        "Specification temperature of (optional) damper cage"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TrRef(start=293.15)
        "Reference temperature of damper resistances in d- and q-axis"
        annotation (Dialog(tab="Material"));
      parameter Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start=
            0) "Temperature coefficient of damper resistances in d- and q-axis"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TeSpecification(start=293.15)
        "Specification excitation temperature"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TeRef(start=293.15)
        "Reference temperature of excitation resistance"
        annotation (Dialog(tab="Material"));
      parameter Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(start=
            0) "Temperature coefficient of excitation resistance"
        annotation (Dialog(tab="Material"));
      final parameter Real xmd=xd - x0
        "Main field reactance per phase, d-axis [pu]";
      final parameter Real xmq=xq - x0
        "Main field reactance per phase, q-axis [pu]";
      final parameter Real xe=xmd^2/(xd - xdTransient)
        "Excitation reactance [pu]";
      final parameter Real xrd=xmd^2/(xdTransient - xdSubtransient)*(1 - (xmd/
          xe))^2 + xmd^2/xe "Damper reactance per phase, d-axis [pu]";
      final parameter Real xrq=xmq^2/(xq - xqSubtransient)
        "Damper reactance per phase, d-axis [pu]";
      final parameter Real rs=2/(1/xdSubtransient + 1/xqSubtransient)/(omega*Ta)
        "Stator resistance per phase at specification temperature [pu]";
      final parameter Real rrd=(xrd - xmd^2/xe)/(omega*Td0Subtransient)
        "Damper resistance per phase at specification temperature, d-axis [pu]";
      final parameter Real rrq=xrq/(omega*Tq0Subtransient)
        "Damper resistance per phase at specification temperature, q-axis [pu]";
      final parameter Real re=xe/(omega*Td0Transient)
        "Excitation resistance per phase at specification temperature [pu]";
      parameter Modelica.SIunits.Resistance Rs=
          Modelica.Electrical.Machines.Thermal.convertResistance(
              rs*ZReference,
              TsSpecification,
              alpha20s,
              TsRef) "Stator resistance per phase at TRef"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lssigma=x0*ZReference/omega
        "Stator stray inductance per phase"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lmd=xmd*ZReference/omega
        "Main field inductance per phase in d-axis"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lmq=xmq*ZReference/omega
        "Main field inductance per phase in q-axis"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lrsigmad=(xrd - xmd)*ZReference/
          omega "Damper stray inductance in d-axis"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lrsigmaq=(xrq - xmq)*ZReference/
          omega "Damper stray inductance in q-axis"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Resistance Rrd=
          Modelica.Electrical.Machines.Thermal.convertResistance(
              rrd*ZReference,
              TrSpecification,
              alpha20r,
              TrRef) "Damper resistance in d-axis at TRef"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Resistance Rrq=
          Modelica.Electrical.Machines.Thermal.convertResistance(
              rrq*ZReference,
              TrSpecification,
              alpha20r,
              TrRef) "Damper resistance in q-axis at TRef"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Resistance Re=3/2*turnsRatio^2*
          Modelica.Electrical.Machines.Thermal.convertResistance(
              re*ZReference,
              TeSpecification,
              alpha20e,
              TeRef) "Excitation resistance at TRef"
        annotation (Dialog(tab="Result", enable=false));
      parameter Real sigmae=1 - xmd/xe
        "Stray fraction of total excitation inductance"
        annotation (Dialog(tab="Result", enable=false));
      annotation (
        defaultComponentName="smeeData",
        defaultComponentPrefixes="parameter",
        Documentation(info="<html>
<p>The parameters of the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited\">
synchronous machine model with electrical excitation (and 
)</a> are calculated from parameters
normally given in a technical description, according to the standard EN&nbsp;60034-4:2008&nbsp;Appendix&nbsp;C.</p>
</html>"));
      end SM300kVA;

      record SM100kVA "100 kVA SG"
        extends Modelica.Icons.Record;
        extends AircraftPowerSystem.Records.Base.Synch;
      import Modelica.Constants.pi;
      parameter Integer Poles = 2 "Number of Poles";
      parameter Modelica.SIunits.ApparentPower SNominal(start=100E3)
        "Nominal apparent power";
      parameter Modelica.SIunits.Voltage VsNominal(start=200)
        "Nominal stator voltage per phase";
      final parameter Modelica.SIunits.Current IsNominal=SNominal/(3*VsNominal)
        "Nominal stator current per phase";
      final parameter Modelica.SIunits.Impedance ZReference=VsNominal/IsNominal
        "Reference impedance";
      parameter Modelica.SIunits.Frequency fsNominal(start=400)
        "Nominal stator frequency";
      final parameter Modelica.SIunits.AngularVelocity omega=2*pi*fsNominal
        "Nominal angular frequency";
      parameter Modelica.SIunits.Current IeOpenCircuit(start=10)
        "Open circuit excitation current @ nominal voltage and frequency";
      parameter Real effectiveStatorTurns=1 "Effective number of stator turns";
      final parameter Real turnsRatio=sqrt(2)*VsNominal/(omega*Lmd*
          IeOpenCircuit) "Stator current / excitation current";
      parameter Real x0(start=0.06)
        "Stator stray inductance per phase (approximately zero impedance) [pu]";
      parameter Real xd(start=2)
        "Synchronous reactance per phase, d-axis [pu]";
      parameter Real xq(start=1.6)
        "Synchronous reactance per phase, q-axis [pu]";
      parameter Real xdTransient(start=0.2)
        "Transient reactance per phase, d-axis [pu]";
      parameter Real xdSubtransient(start=0.15)
        "Subtransient reactance per phase, d-axis [pu]";
      parameter Real xqSubtransient(start=0.15)
        "Subtransient reactance per phase, q-axis [pu]";
      parameter Modelica.SIunits.Time Ta(start=0.014171268)
        "Armature time constant";
      parameter Modelica.SIunits.Time Td0Transient(start=5)
        "Open circuit field time constant Td0'";
      parameter Modelica.SIunits.Time Td0Subtransient(start=0.031)
        "Open circuit subtransient time constant Td0'', d-axis";
      parameter Modelica.SIunits.Time Tq0Subtransient(start=0.061)
        "Open circuit subtransient time constant Tq0'', q-axis";
      parameter Modelica.SIunits.Temperature TsSpecification(start=293.15)
        "Specification temperature of stator resistance"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TsRef(start=293.15)
        "Reference temperature of stator resistance"
        annotation (Dialog(tab="Material"));
      parameter Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 alpha20s(start=
            0) "Temperature coefficient of stator resistance at 20 degC"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TrSpecification(start=293.15)
        "Specification temperature of (optional) damper cage"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TrRef(start=293.15)
        "Reference temperature of damper resistances in d- and q-axis"
        annotation (Dialog(tab="Material"));
      parameter Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 alpha20r(start=
            0) "Temperature coefficient of damper resistances in d- and q-axis"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TeSpecification(start=293.15)
        "Specification excitation temperature"
        annotation (Dialog(tab="Material"));
      parameter Modelica.SIunits.Temperature TeRef(start=293.15)
        "Reference temperature of excitation resistance"
        annotation (Dialog(tab="Material"));
      parameter Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20 alpha20e(start=
            0) "Temperature coefficient of excitation resistance"
        annotation (Dialog(tab="Material"));
      final parameter Real xmd=xd - x0
        "Main field reactance per phase, d-axis [pu]";
      final parameter Real xmq=xq - x0
        "Main field reactance per phase, q-axis [pu]";
      final parameter Real xe=xmd^2/(xd - xdTransient)
        "Excitation reactance [pu]";
      final parameter Real xrd=xmd^2/(xdTransient - xdSubtransient)*(1 - (xmd/
          xe))^2 + xmd^2/xe "Damper reactance per phase, d-axis [pu]";
      final parameter Real xrq=xmq^2/(xq - xqSubtransient)
        "Damper reactance per phase, d-axis [pu]";
      final parameter Real rs=2/(1/xdSubtransient + 1/xqSubtransient)/(omega*Ta)
        "Stator resistance per phase at specification temperature [pu]";
      final parameter Real rrd=(xrd - xmd^2/xe)/(omega*Td0Subtransient)
        "Damper resistance per phase at specification temperature, d-axis [pu]";
      final parameter Real rrq=xrq/(omega*Tq0Subtransient)
        "Damper resistance per phase at specification temperature, q-axis [pu]";
      final parameter Real re=xe/(omega*Td0Transient)
        "Excitation resistance per phase at specification temperature [pu]";
      parameter Modelica.SIunits.Resistance Rs=
          Modelica.Electrical.Machines.Thermal.convertResistance(
              rs*ZReference,
              TsSpecification,
              alpha20s,
              TsRef) "Stator resistance per phase at TRef"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lssigma=x0*ZReference/omega
        "Stator stray inductance per phase"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lmd=xmd*ZReference/omega
        "Main field inductance per phase in d-axis"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lmq=xmq*ZReference/omega
        "Main field inductance per phase in q-axis"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lrsigmad=(xrd - xmd)*ZReference/
          omega "Damper stray inductance in d-axis"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Inductance Lrsigmaq=(xrq - xmq)*ZReference/
          omega "Damper stray inductance in q-axis"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Resistance Rrd=
          Modelica.Electrical.Machines.Thermal.convertResistance(
              rrd*ZReference,
              TrSpecification,
              alpha20r,
              TrRef) "Damper resistance in d-axis at TRef"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Resistance Rrq=
          Modelica.Electrical.Machines.Thermal.convertResistance(
              rrq*ZReference,
              TrSpecification,
              alpha20r,
              TrRef) "Damper resistance in q-axis at TRef"
        annotation (Dialog(tab="Result", enable=false));
      parameter Modelica.SIunits.Resistance Re=3/2*turnsRatio^2*
          Modelica.Electrical.Machines.Thermal.convertResistance(
              re*ZReference,
              TeSpecification,
              alpha20e,
              TeRef) "Excitation resistance at TRef"
        annotation (Dialog(tab="Result", enable=false));
      parameter Real sigmae=1 - xmd/xe
        "Stray fraction of total excitation inductance"
        annotation (Dialog(tab="Result", enable=false));
      annotation (
        defaultComponentName="smeeData",
        defaultComponentPrefixes="parameter",
        Documentation(info="<html>
<p>The parameters of the
<a href=\"modelica://Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited\">
synchronous machine model with electrical excitation (and damper)</a> are calculated from parameters
normally given in a technical description, according to the standard EN&nbsp;60034-4:2008&nbsp;Appendix&nbsp;C.</p>
</html>"));
      end SM100kVA;
    end SynchronousMachine;

    package DCMotor
      package FuelPumps
        record FuelPump_1
          extends Base.DC_Motor_Data(
          Ra = 0.35,
          La = 0.0001,
          Rf = 240,
          Lf = 12,
          Laf = 1,
          J = 0.0005);
        end FuelPump_1;

        record FuelPump_2
          extends Base.DC_Motor_Data(
          Ra = 0.35,
          La = 0.0001,
          Rf = 240,
          Lf = 12,
          Laf = 1,
          J = 0.0005);
        end FuelPump_2;
      end FuelPumps;
    end DCMotor;

    package PMSM
      record PMSM_2kVA "2 KVA PMSM"
        extends AircraftPowerSystem.Records.PMSM.PSM;
        extends SM_ReluctanceRotorData(Lmd=8.5e-3, Lmq=8.5e-3);
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Voltage VsOpenCircuit=127
          "Open circuit RMS voltage per phase @ fsNominal";
        parameter Modelica.Electrical.Machines.Losses.PermanentMagnetLossParameters
          permanentMagnetLossParameters(
          PRef=0,
          IRef=100,
          wRef=2*pi*fsNominal/p) "Permanent magnet loss parameter record"
          annotation (Dialog(tab="Losses"));
        annotation (
          defaultComponentName="smpmData",
          defaultComponentPrefixes="parameter",
          Documentation(info="<html>
<p>Basic parameters of synchronous induction machines with permanent magnet are predefined with default values.</p>
</html>"));
      end PMSM_2kVA;

      record SM_ReluctanceRotorData
        "Common parameters for synchronous induction machines with reluctance rotor"
        extends AircraftPowerSystem.Records.PMSM.InductionMachineData(Lssigma=
              0.1/(2*pi*fsNominal));
        import Modelica.Constants.pi;
        parameter Modelica.SIunits.Inductance Lmd=8.5e-3
          "Stator main field inductance per phase in d-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lmq=8.5e-3
          "Stator main field inductance per phase in q-axis"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Boolean useDamperCage=true "Enable / disable damper cage"
          annotation (Evaluate=true,Dialog(tab=
                "Nominal resistances and inductances", group="DamperCage"));
        parameter Modelica.SIunits.Inductance Lrsigmad=0.05/(2*pi*fsNominal)
          "Damper stray inductance in d-axis" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Inductance Lrsigmaq=Lrsigmad
          "Damper stray inductance in q-axis" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrd=0.04
          "Damper resistance in d-axis at TRef" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Resistance Rrq=Rrd
          "Damper resistance in q-axis at TRef" annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.SIunits.Temperature TrRef=293.15
          "Reference temperature of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        parameter Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20r=0 "Temperature coefficient of damper resistances in d- and q-axis"
          annotation (Dialog(
            tab="Nominal resistances and inductances",
            group="DamperCage",
            enable=useDamperCage));
        annotation (
          defaultComponentName="smrData",
          defaultComponentPrefixes="parameter",
          Documentation(info="<html>
<p>Basic parameters of synchronous induction machines with reluctance rotor are predefined with default values.</p>
</html>"));
      end SM_ReluctanceRotorData;

      record InductionMachineData
        "Common parameters for induction machines"
        extends Modelica.Icons.Record;
        import Modelica.Constants.pi;
        final parameter Integer m=3 "Number of phases";
        parameter Modelica.SIunits.Inertia Jr=0.089 "Rotor's moment of inertia";
        parameter Modelica.SIunits.Inertia Js=Jr "Stator's moment of inertia";
        parameter Integer p(min=1) = 4 "Number of pole pairs (Integer)";
        parameter Modelica.SIunits.Frequency fsNominal=60 "Nominal frequency";
        parameter Modelica.SIunits.Resistance Rs=0.2
          "Stator resistance per phase at TRef"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Temperature TsRef=293.15
          "Reference temperature of stator resistance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.Electrical.Machines.Thermal.LinearTemperatureCoefficient20
          alpha20s=0 "Temperature coefficient of stator resistance at 20 degC"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Real effectiveStatorTurns=1 "Effective number of stator turns";
        parameter Modelica.SIunits.Inductance Lszero=Lssigma
          "Stator zero sequence inductance"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.SIunits.Inductance Lssigma=3*(1 - sqrt(1 - 0.0667))/
            (2*pi*fsNominal) "Stator stray inductance per phase"
          annotation (Dialog(tab="Nominal resistances and inductances"));
        parameter Modelica.Electrical.Machines.Losses.FrictionParameters frictionParameters(PRef=0,
            wRef=2*pi*fsNominal/p) "Friction loss parameter record"
          annotation (Dialog(tab="Losses"));
        parameter Modelica.Electrical.Machines.Losses.CoreParameters statorCoreParameters(
          final m=m,
          PRef=0,
          VRef=100,
          wRef=2*pi*fsNominal)
          "Stator core loss parameter record; all parameters refer to stator side"
          annotation (Dialog(tab="Losses"));
        parameter Modelica.Electrical.Machines.Losses.StrayLoadParameters strayLoadParameters(
          PRef=0,
          IRef=100,
          wRef=2*pi*fsNominal/p) "Stray load losses" annotation (Dialog(tab="Losses"));
        annotation (
          defaultComponentName="inductionMachineData",
          defaultComponentPrefixes="parameter",
          Documentation(info="<html>
<p>Basic parameters of induction machines are predefined with default values.</p>
</html>"));
      end InductionMachineData;

      record PSM
        extends Modelica.Icons.Record
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end PSM;
    end PMSM;

    package Controllers

      record TypeI_AVR
        extends AircraftPowerSystem.Records.Base.AVR;
        extends Modelica.Icons.Record;
        parameter Real T_R = 0.01  "Rate Filter Time Constant";
        parameter Real T_C = 0.001 "TGR Time Constant";
        parameter Real T_B = 0.001  "TGR Time Constant";
        parameter Real K_A = 46   "Regulator Gain";
        parameter Real T_A = 0.06 "Regulator Time Constant";
        parameter Real K_E = 1     "Exciter Gain";
        parameter Real T_E = 0.46  "Exciter Time Constant";
        parameter Real K_F = 0.1 "Rate Feedback Gain";
        parameter Real T_F = 1  "Rate Feedback Time Constant";
        parameter Real Vmax = 1.7  "Regulator Maximum Output";
        parameter Real Vmin = -1.7 "Regulator Minimum Output";
        parameter Real K_C = 0.2   "Commutation reactance coefficient";


        parameter Real K_D = 1;
        parameter Real Efdmax = 3 "Excitation voltage maximum";
        parameter Real Efdmin = 0    "Excitation voltage minimum";
        parameter Real K_p = 4.365    "Excitation voltage minimum";
        parameter Real K_i = 4.83     "Excitation voltage minimum";
        parameter Real K_G = 1;
        parameter Real K_M = 7.04;
        parameter Real T_M = 0.4;
        parameter Real V_Mmax = 7.57;
        parameter Real V_Mmin = 0;
        parameter Real X_L = 0.091;
        parameter Real V_Gmax = 6.53;
        parameter Real th = 0.3489;
        parameter Real K_g = 1;
        parameter Real V_Imax = 0.2;
        parameter Real V_Imin = -0.2;


        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end TypeI_AVR;

      record AVR_AC1A
        extends AircraftPowerSystem.Records.Base.AVR;
        extends Modelica.Icons.Record;
        parameter Real T_R = 0.01  "Rate Filter Time Constant";
        parameter Real T_C = 0.001  "TGR Time Constant";
        parameter Real T_B = 0.001  "TGR Time Constant";
        parameter Real K_A = 200   "Regulator Gain";
        parameter Real T_A = 0.1   "Regulator Time Constant";
        parameter Real K_E = 1     "Exciter Gain";
        parameter Real T_E = 0.1   "Exciter Time Constant";
        parameter Real K_F = 0.1   "Rate Feedback Gain";
        parameter Real T_F = 1     "Rate Feedback Time Constant";
        parameter Real K_D = 0.38  "Armatture reactance demagnetizing coeffcient";
        parameter Real K_C = 0.2   "Commutation reactance coefficient";
        parameter Real Vmax = 15  "Regulator Maximum Output";
        parameter Real Vmin = -15 "Regulator Minimum Output";


        parameter Real Efdmax = 3 "Excitation voltage maximum";
        parameter Real Efdmin = 0    "Excitation voltage minimum";
        parameter Real K_p = 4.365    "Excitation voltage minimum";
        parameter Real K_i = 4.83     "Excitation voltage minimum";
        parameter Real K_G = 1;
        parameter Real K_M = 7.04;
        parameter Real T_M = 0.4;
        parameter Real V_Mmax = 7.57;
        parameter Real V_Mmin = 0;
        parameter Real X_L = 0.091;
        parameter Real V_Gmax = 6.53;
        parameter Real th = 0.3489;
        parameter Real V_Imax = 0.2;
        parameter Real V_Imin = -0.2;

        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(
            StopTime=20,
            Interval=0.0001,
            __Dymola_fixedstepsize=0.001,
            __Dymola_Algorithm="Cvode"),
          __Dymola_experimentFlags(Advanced(
              InlineMethod=1,
              InlineOrder=2,
              InlineFixedStep=0.001)));
      end AVR_AC1A;

      record AVR_ST3
        extends AircraftPowerSystem.Records.Base.AVR;
        extends Modelica.Icons.Record;
        parameter Real T_R = 5e-3    "Rate Filter Time Constant";
        parameter Real T_C = 0.001       "TGR Time Constant";
        parameter Real T_B = 0.001    "TGR Time Constant";
        parameter Real K_A = 20     "Regulator Gain";
        parameter Real T_A = 0.001    "Regulator Time Constant";
        parameter Real K_E = 1       "Exciter Gain";
        parameter Real T_E = 0.5     "Exciter Time Constant";
        parameter Real K_F = 0.02    "Rate Feedback Gain";
        parameter Real T_F = 0.56    "Rate Feedback Time Constant";
        parameter Real K_D = 0.38    "Armatture reactance demagnetizing coeffcient";
        parameter Real K_C = 1.096   "Commutation reactance coefficient";
        parameter Real Vmax = 7.57   "Regulator Maximum Output";
        parameter Real Vmin = 0      "Regulator Minimum Output";

        parameter Real Efdmax = 6.53 "Excitation voltage maximum";
        parameter Real Efdmin = 0    "Excitation voltage minimum";
        parameter Real K_p = 4.365    "Excitation voltage minimum";
        parameter Real K_i = 4.83     "Excitation voltage minimum";
        parameter Real K_G = 1;
        parameter Real K_M = 7.04;
        parameter Real T_M = 0.4;
        parameter Real V_Mmax = 7.57;
        parameter Real V_Mmin = 0;
        parameter Real X_L = 0.091;
        parameter Real V_Gmax = 6.53;
        parameter Real th = 0.3489;
        parameter Real V_Imax = 0.2;
        parameter Real V_Imin = -0.2;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end AVR_ST3;
    end Controllers;

    package Base
      record DC_Motor_Data
        extends Modelica.Icons.Record;
        parameter Modelica.SIunits.Resistance  Ra "Armature Resistance";
        parameter Modelica.SIunits.Inductance  La "Armature Inductance";
        parameter Modelica.SIunits.Resistance  Rf "Field Resistance";
        parameter Modelica.SIunits.Inductance  Lf "Field Inductance";
        parameter Modelica.SIunits.Inductance  Laf "Field- armature Mutual Inductance";
        parameter Modelica.SIunits.Inertia J "Inertia";
      end DC_Motor_Data;

      record Synch
        extends Modelica.Icons.Record;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Synch;

      record AVR
        extends Modelica.Icons.Record
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end AVR;

      record IM
        extends Modelica.Icons.Record;
        parameter Integer p "Number of Poles";
        parameter Real fsNominal "Nominal Operating Frequency";
        parameter Real J "Rotor Inertia";
        parameter Real Rs "Stator Resistance";
        parameter Real Lss "Stray Inductance per phase";
        parameter Real Lm "Stator main field inductance per pahse";
        parameter Real Lr "Rotor stray inductance";
        parameter Real Rr "Rotor resistance per phase";
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));

      end IM;
      annotation (Documentation(info="<html>
<p>Base Classes to Make Easy Replaceable Records</p>
</html>"));
    end Base;

    package InductionMachine
      record IM_30KVA "30 KVA Induction Motor"
        extends Base.IM(p = 8,
                        fsNominal = 400,
                        J = 0.01,
                        Rs = 0.2761,
                        Lss = 0.0002191,
                        Lm = 0.07614,
                        Lr = 0.0002191,
                        Rr = 0.16);
      end IM_30KVA;
    end InductionMachine;
  end Records;

  package Controls

    package PMSM
      model SpeedController
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter Real K_ref = 1 "Reference Proportional Gain";
        parameter Real T_ref = 0.1 "Reference Integrator Time Constant";
        parameter Integer p "Number of pole pairs";
        parameter Modelica.SIunits.Frequency fsNominal "Nominal frequency";
        parameter Modelica.SIunits.Voltage VsOpenCircuit
          "Open circuit RMS voltage per phase @ fsNominal";
        parameter Modelica.SIunits.Resistance Rs "Stator resistance per phase";
        parameter Modelica.SIunits.Inductance Ld "Inductance in d-axis";
        parameter Modelica.SIunits.Inductance Lq "Inductance in q-axis";
        //Decoupling
        parameter Boolean decoupling=false "Use decoupling network";
        final parameter Modelica.SIunits.MagneticFlux psiM=sqrt(2)*VsOpenCircuit/
            (2*pi*fsNominal);
        Modelica.SIunits.AngularVelocity omega;
        Modelica.SIunits.Voltage Vd;
        Modelica.SIunits.Voltage Vq;
        Modelica.SIunits.Current iq_rms;
        Modelica.SIunits.Current id_rms;

        Modelica.Blocks.Interfaces.RealOutput a
          annotation (Placement(transformation(extent={{380,78},{400,98}})));
        Modelica.Blocks.Interfaces.RealOutput b
          annotation (Placement(transformation(extent={{380,-10},{400,10}}),
              iconTransformation(extent={{380,-10},{400,10}})));
        Modelica.Blocks.Interfaces.RealOutput c
          annotation (Placement(transformation(extent={{380,-120},{400,-100}}),
              iconTransformation(extent={{380,-120},{400,-100}})));
        Modelica.Electrical.Machines.Utilities.FromDQ
                                  fromDQ(final p=p, final m=m)
          annotation (Placement(transformation(extent={{228,-4},{248,16}})));
        Modelica.Electrical.Machines.Utilities.ToDQ
                                toDQ(final p=p, final m=m)
                                                annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-90,-64})));
        Modelica.Blocks.Math.Division division
          annotation (Placement(transformation(extent={{316,78},{336,98}})));
        Modelica.Blocks.Math.Division division1
          annotation (Placement(transformation(extent={{318,-10},{338,10}})));
        Modelica.Blocks.Math.Division division2
          annotation (Placement(transformation(extent={{322,-102},{342,-82}})));
        Modelica.Blocks.Math.Max max annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={228,-78})));
        Modelica.Blocks.Sources.Constant const(k=0.0001)
          annotation (Placement(transformation(extent={{140,-102},{160,-82}})));
        Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=-1)
          annotation (Placement(transformation(extent={{348,78},{368,98}})));
        Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=-1)
          annotation (Placement(transformation(extent={{348,-10},{368,10}})));
        Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=1, uMin=-1)
          annotation (Placement(transformation(extent={{354,-102},{374,-82}})));
        Modelica.Blocks.Interfaces.RealInput Vdc1 annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={234,-120}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={254,-100})));
        Modelica.Blocks.Interfaces.RealInput iActual[m] annotation (Placement(
              transformation(
              origin={-90,-120},
              extent={{20,-20},{-20,20}},
              rotation=270), iconTransformation(
              extent={{20,-20},{-20,20}},
              rotation=270,
              origin={22,-100})));
        Modelica.Blocks.Interfaces.RealInput phi(unit="rad") annotation (Placement(
              transformation(
              origin={60,-120},
              extent={{20,-20},{-20,20}},
              rotation=270), iconTransformation(
              extent={{20,-20},{-20,20}},
              rotation=270,
              origin={142,-100})));

        Modelica.Blocks.Routing.Multiplex2 multiplex2_1
          annotation (Placement(transformation(extent={{154,2},{174,22}})));
        Modelica.Blocks.Sources.Constant const1(k=0)
          annotation (Placement(transformation(extent={{-8,54},{12,74}})));
        Modelica.Blocks.Math.Add add1
                                    [2](final k1=fill(+1, 2), final k2=fill(if
              decoupling then +1 else 0, 2))
          annotation (Placement(transformation(extent={{202,-4},{222,16}})));
        Modelica.Blocks.Sources.RealExpression deCoupling[2](y={Vd,Vq})
          annotation (Placement(transformation(extent={{130,-36},{150,-16}})));
        Modelica.Blocks.Continuous.LimPID Iq_ref(
          k=K_ref,
          Ti=T_ref,
          Td=0,
          yMax=200,
          yMin=-200,
          withFeedForward=false,
          kFF=0.01)
          annotation (Placement(transformation(extent={{6,-4},{26,16}})));
        Modelica.Blocks.Routing.DeMultiplex demux1(n=2)
                                                       annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={20,-42})));
        Modelica.Blocks.Continuous.LimPID Id(
          k=1/Rs,
          Ti=Ld/Rs,
          Td=0,
          yMax=200,
          yMin=-200,
          withFeedForward=false,
          kFF=0.01,
          initType=Modelica.Blocks.Types.InitPID.NoInit,
          xi_start=0,
          xd_start=0)
          annotation (Placement(transformation(extent={{102,54},{122,74}})));
        Modelica.Blocks.Continuous.LimPID Iq(
          k=1/Rs,
          Ti=Lq/Rs,
          Td=0,
          yMax=200,
          yMin=-200,
          withFeedForward=false,
          kFF=0.01,
          initType=Modelica.Blocks.Types.InitPID.NoInit,
          xi_start=0,
          xd_start=0)
          annotation (Placement(transformation(extent={{100,-4},{120,16}})));
        Modelica.Blocks.Interfaces.RealInput Speed annotation (Placement(
              transformation(
              origin={-100,-6},
              extent={{20,-20},{-20,20}},
              rotation=180), iconTransformation(
              extent={{20,-20},{-20,20}},
              rotation=180,
              origin={-80,0})));
        Modelica.Blocks.Routing.DeMultiplex demux2(n=3)
                                                       annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={270,6})));
        Modelica.Blocks.Math.Gain gain(k=1/sqrt(2))
          annotation (Placement(transformation(extent={{72,30},{92,50}})));
        Modelica.Blocks.Math.Gain gain1(k=1/sqrt(2))
          annotation (Placement(transformation(extent={{78,-56},{98,-36}})));
        parameter Real Iqmax=100 "Upper Limit of Currents";

        Modelica.Blocks.Interfaces.RealInput Ref annotation (Placement(transformation(
              origin={-100,100},
              extent={{20,-20},{-20,20}},
              rotation=180), iconTransformation(
              extent={{20,-20},{-20,20}},
              rotation=180,
              origin={-80,82})));
      protected
        constant Modelica.SIunits.Resistance unitResistance=1;

      equation
        omega=Speed;
        Vd = (Rs*id_rms - omega*Lq*iq_rms);
        Vq = (Rs*iq_rms + omega*Ld*id_rms) + omega
            *psiM;
        iq_rms = toDQ.y[2]/sqrt(2);
        id_rms = toDQ.y[1]/sqrt(2);

        connect(iActual,toDQ. u) annotation (Line(
            points={{-90,-120},{-90,-76}}, color={0,0,127}));
        connect(max.u2, Vdc1)
          annotation (Line(points={{234,-90},{234,-120}}, color={0,0,127}));
        connect(const.y, max.u1)
          annotation (Line(points={{161,-92},{222,-92},{222,-90}}, color={0,0,127}));
        connect(limiter.u, division.y)
          annotation (Line(points={{346,88},{337,88}}, color={0,0,127}));
        connect(limiter2.u, division2.y) annotation (Line(points={{352,-92},{343,-92}},
                                      color={0,0,127}));
        connect(limiter1.u, division1.y)
          annotation (Line(points={{346,0},{339,0}},   color={0,0,127}));
        connect(division.u2, division1.u2) annotation (Line(points={{314,82},{304,82},
                {304,-6},{316,-6}},   color={0,0,127}));
        connect(division2.u2, division1.u2) annotation (Line(points={{320,-98},{304,-98},
                {304,-6},{316,-6}},   color={0,0,127}));
        connect(max.y, division1.u2) annotation (Line(points={{228,-67},{228,-56},{304,
                -56},{304,-6},{316,-6}},   color={0,0,127}));
        connect(add1.y, fromDQ.u)
          annotation (Line(points={{223,6},{226,6}}, color={0,0,127}));
        connect(deCoupling.y, add1.u2) annotation (Line(points={{151,-26},{184,-26},{
                184,0},{200,0}}, color={0,0,127}));
        connect(add1.u1, multiplex2_1.y)
          annotation (Line(points={{200,12},{175,12}}, color={0,0,127}));
        connect(limiter.y, a)
          annotation (Line(points={{369,88},{390,88}}, color={0,0,127}));
        connect(limiter1.y, b) annotation (Line(points={{369,0},{374,0},{374,0},{390,0}},
                      color={0,0,127}));
        connect(limiter2.y, c) annotation (Line(points={{375,-92},{382,-92},{382,-110},
                {390,-110}},color={0,0,127}));
        connect(demux1.u, toDQ.y) annotation (Line(points={{8,-42},{-90,-42},{-90,-53}},
                                   color={0,0,127}));
        connect(Id.y, multiplex2_1.u1[1]) annotation (Line(points={{123,64},{
                126,64},{126,18},{152,18}}, color={0,0,127}));
        connect(Iq.y, multiplex2_1.u2[1])
          annotation (Line(points={{121,6},{152,6}}, color={0,0,127}));
        connect(Id.u_s, const1.y)
          annotation (Line(points={{100,64},{13,64}}, color={0,0,127}));
        connect(Iq_ref.u_m, Speed)
          annotation (Line(points={{16,-6},{-100,-6}}, color={0,0,127}));
        connect(Iq.u_s, Iq_ref.y)
          annotation (Line(points={{98,6},{27,6}}, color={0,0,127}));
        connect(division.u1, demux2.y[1]) annotation (Line(points={{314,94},{
                298,94},{298,10.6667},{280,10.6667}},
                                             color={0,0,127}));
        connect(division1.u1, demux2.y[2]) annotation (Line(points={{316,6},{298,6},{298,
                6},{280,6}}, color={0,0,127}));
        connect(division2.u1, demux2.y[3]) annotation (Line(points={{320,-86},{302,-86},
                {302,1.33333},{280,1.33333}}, color={0,0,127}));
        connect(demux2.u, fromDQ.y)
          annotation (Line(points={{258,6},{249,6}}, color={0,0,127}));
        connect(fromDQ.phi, phi) annotation (Line(points={{238,-6},{236,-6},{236,-46},
                {230,-46},{230,-62},{60,-62},{60,-120}}, color={0,0,127}));
        connect(toDQ.phi, phi) annotation (Line(points={{-78,-64},{-10,-64},{-10,-66},
                {60,-66},{60,-120}}, color={0,0,127}));
        connect(gain.y, Id.u_m)
          annotation (Line(points={{93,40},{112,40},{112,52}}, color={0,0,127}));
        connect(gain.u, demux1.y[1]) annotation (Line(points={{70,40},{62,40},{62,-38.5},
                {30,-38.5}}, color={0,0,127}));
        connect(gain1.y, Iq.u_m) annotation (Line(points={{99,-46},{99,-24},{110,-24},
                {110,-6}}, color={0,0,127}));
        connect(gain1.u, demux1.y[2]) annotation (Line(points={{76,-46},{64,-46},{64,-45.5},
                {30,-45.5}}, color={0,0,127}));
        connect(Iq_ref.u_s, Ref) annotation (Line(points={{4,6},{-38,6},{-38,100},{-100,
                100}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},
                  {380,100}}), graphics={Text(
                extent={{50,36},{316,-24}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={215,215,215},
                fillPattern=FillPattern.None,
                textStyle={TextStyle.Bold},
                textString="PI Speed Control
"),       Rectangle(
                extent={{-100,100},{380,-120}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={215,215,215},
                fillPattern=FillPattern.None)}),
                                           Diagram(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-120},{380,100}})),
          experiment(
            StopTime=1000,
            __Dymola_NumberOfIntervals=500000,
            Tolerance=1e-08));
      end SpeedController;

      model SpeedController_IM
        import Modelica.Constants.pi;
        constant Integer m=3 "Number of phases";
        parameter Real K_ref = 1 "Reference Proportional Gain";
        parameter Real T_ref = 0.1 "Reference Integrator Time Constant";
        parameter Integer p "Number of pole pairs";
        parameter Real Psi_ref = 10 "Flux Reference";
        parameter Real Rr "Rotor Resistance";
        parameter Real Lr "Rotor Inductance";
        parameter Real Lm "Magnetization Inductance";
        parameter Real Tr "Rotor Time Constant";

        Modelica.Blocks.Interfaces.RealOutput a
          annotation (Placement(transformation(extent={{380,78},{400,98}})));
        Modelica.Blocks.Interfaces.RealOutput b
          annotation (Placement(transformation(extent={{380,-10},{400,10}}),
              iconTransformation(extent={{380,-10},{400,10}})));
        Modelica.Blocks.Interfaces.RealOutput c
          annotation (Placement(transformation(extent={{380,-102},{400,-82}}),
              iconTransformation(extent={{380,-102},{400,-82}})));
        Modelica.Electrical.Machines.Utilities.FromDQ
                                  fromDQ(final p=p, final m=m)
          annotation (Placement(transformation(extent={{222,110},{242,130}})));
        Modelica.Blocks.Math.Division division
          annotation (Placement(transformation(extent={{314,108},{334,128}})));
        Modelica.Blocks.Math.Division division1
          annotation (Placement(transformation(extent={{320,-2},{340,18}})));
        Modelica.Blocks.Math.Division division2
          annotation (Placement(transformation(extent={{322,-102},{342,-82}})));
        Modelica.Blocks.Math.Max max annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={228,-78})));
        Modelica.Blocks.Sources.Constant const(k=0.0001)
          annotation (Placement(transformation(extent={{140,-102},{160,-82}})));
        Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=-1)
          annotation (Placement(transformation(extent={{342,108},{362,128}})));
        Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=-1)
          annotation (Placement(transformation(extent={{350,-2},{370,18}})));
        Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=1, uMin=-1)
          annotation (Placement(transformation(extent={{354,-102},{374,-82}})));
        Modelica.Blocks.Interfaces.RealInput Vdc1 annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={234,-120}), iconTransformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={254,-100})));

        Modelica.Blocks.Routing.Multiplex2 multiplex2_1
          annotation (Placement(transformation(extent={{170,110},{190,130}})));
        Modelica.Blocks.Sources.Constant Flux_Ref(k=Psi_ref)
          annotation (Placement(transformation(extent={{-96,116},{-76,136}})));
        Modelica.Blocks.Continuous.LimPID Torque_ref(
          k=K_ref,
          Ti=T_ref,
          Td=0,
          yMax=Iqmax,
          yMin=-Iqmax,
          withFeedForward=false,
          kFF=0.01) annotation (Placement(transformation(extent={{-10,84},{10,104}})));
        Modelica.Blocks.Interfaces.RealInput Speed annotation (Placement(
              transformation(
              origin={-100,-92},
              extent={{20,-20},{-20,20}},
              rotation=180), iconTransformation(
              extent={{20,-20},{-20,20}},
              rotation=180,
              origin={-80,0})));
        Modelica.Blocks.Routing.DeMultiplex demux2(n=3)
                                                       annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={260,120})));
        parameter Real Iqmax=100 "Upper Limit of Currents";

        Modelica.Blocks.Interfaces.RealInput Ref annotation (Placement(transformation(
              origin={-100,94},
              extent={{20,-20},{-20,20}},
              rotation=180), iconTransformation(
              extent={{20,-20},{-20,20}},
              rotation=180,
              origin={-80,82})));
        Modelica.Blocks.Math.Gain w_e(k=p/2)
          annotation (Placement(transformation(extent={{-66,2},{-46,22}})));
        Modelica.Electrical.Machines.Utilities.ToDQ
                                toDQ(final p=p, final m=m)
                                                annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-22,-84})));
        Modelica.Blocks.Interfaces.RealInput iActual[m] annotation (Placement(
              transformation(
              origin={-22,-120},
              extent={{20,-20},{-20,20}},
              rotation=270), iconTransformation(
              extent={{20,-20},{-20,20}},
              rotation=270,
              origin={22,-100})));
        Modelica.Blocks.Continuous.LimPID Vd_ref(
          k=1,
          Ti=0.1,
          Td=0,
          yMax=Iqmax,
          yMin=-Iqmax,
          withFeedForward=false,
          kFF=0.01)
          annotation (Placement(transformation(extent={{-32,116},{-12,136}})));
        Modelica.Blocks.Continuous.LimPID Vq_ref(
          k=1,
          Ti=0.1,
          Td=0,
          yMax=Iqmax,
          yMin=-Iqmax,
          withFeedForward=false,
          kFF=0.01) annotation (Placement(transformation(extent={{130,78},{150,
                  98}})));
        Modelica.Blocks.Routing.DeMultiplex demux1(n=2)
                                                       annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-22,-48})));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{170,16},{190,36}})));
        Modelica.Blocks.Continuous.Integrator integrator
          annotation (Placement(transformation(extent={{206,16},{226,36}})));
        Modelica.Blocks.Continuous.FirstOrder Psi_est(k=Lm, T=Tr,
          y_start=0.001)
          annotation (Placement(transformation(extent={{14,40},{34,60}})));
        Modelica.Blocks.Math.Gain T_to_iq(k=(4*Lr)/(3*p*Lm)) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={46,94})));
        Modelica.Blocks.Math.Division I_qref
          annotation (Placement(transformation(extent={{84,78},{104,98}})));
        Modelica.Blocks.Math.Gain to_wsl(k=Rr*Lm/Lr)   annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={38,6})));
        Modelica.Blocks.Math.Division division4
          annotation (Placement(transformation(extent={{112,-10},{132,10}})));
      protected
        constant Modelica.SIunits.Resistance unitResistance=1;

      equation

        connect(max.u2, Vdc1)
          annotation (Line(points={{234,-90},{234,-120}}, color={0,0,127}));
        connect(const.y, max.u1)
          annotation (Line(points={{161,-92},{222,-92},{222,-90}}, color={0,0,127}));
        connect(limiter.u, division.y)
          annotation (Line(points={{340,118},{335,118}},
                                                       color={0,0,127}));
        connect(limiter2.u, division2.y) annotation (Line(points={{352,-92},{343,-92}},
                                      color={0,0,127}));
        connect(limiter1.u, division1.y)
          annotation (Line(points={{348,8},{341,8}},   color={0,0,127}));
        connect(division.u2, division1.u2) annotation (Line(points={{312,112},{304,112},
                {304,2},{318,2}},     color={0,0,127}));
        connect(division2.u2, division1.u2) annotation (Line(points={{320,-98},{304,-98},
                {304,2},{318,2}},     color={0,0,127}));
        connect(max.y, division1.u2) annotation (Line(points={{228,-67},{228,-56},{304,
                -56},{304,2},{318,2}},     color={0,0,127}));
        connect(limiter.y, a)
          annotation (Line(points={{363,118},{380,118},{380,88},{390,88}},
                                                       color={0,0,127}));
        connect(limiter1.y, b) annotation (Line(points={{371,8},{374,8},{374,0},{390,0}},
                      color={0,0,127}));
        connect(limiter2.y, c) annotation (Line(points={{375,-92},{390,-92}},
                            color={0,0,127}));
        connect(demux2.u, fromDQ.y)
          annotation (Line(points={{248,120},{243,120}},
                                                     color={0,0,127}));
        connect(Torque_ref.u_s, Ref)
          annotation (Line(points={{-12,94},{-100,94}}, color={0,0,127}));
        connect(multiplex2_1.y, fromDQ.u) annotation (Line(points={{191,120},{
                220,120}},                color={0,0,127}));
        connect(w_e.u, Speed)
          annotation (Line(points={{-68,12},{-80,12},{-80,-92},{-100,-92}},
                                                          color={0,0,127}));
        connect(iActual,toDQ. u) annotation (Line(
            points={{-22,-120},{-22,-96}}, color={0,0,127}));
        connect(demux1.u, toDQ.y)
          annotation (Line(points={{-22,-60},{-22,-73}}, color={0,0,127}));
        connect(Vq_ref.y, multiplex2_1.u2[1]) annotation (Line(points={{151,88},
                {160,88},{160,114},{168,114}},
                                      color={0,0,127}));
        connect(multiplex2_1.u1[1], Vd_ref.y)
          annotation (Line(points={{168,126},{-11,126}}, color={0,0,127}));
        connect(division.u1, demux2.y[1]) annotation (Line(points={{312,124},{
                290,124},{290,124.667},{270,124.667}},
                                              color={0,0,127}));
        connect(division1.u1, demux2.y[2]) annotation (Line(points={{318,14},{292,14},
                {292,120},{270,120}}, color={0,0,127}));
        connect(division2.u1, demux2.y[3]) annotation (Line(points={{320,-86},{
                320,-3},{270,-3},{270,115.333}},
                                         color={0,0,127}));
        connect(Psi_est.u, Vd_ref.u_m)
          annotation (Line(points={{12,50},{-22,50},{-22,114}}, color={0,0,127}));
        connect(T_to_iq.u, Torque_ref.y)
          annotation (Line(points={{34,94},{11,94}}, color={0,0,127}));
        connect(I_qref.u1, T_to_iq.y)
          annotation (Line(points={{82,94},{57,94}}, color={0,0,127}));
        connect(I_qref.u2, Psi_est.y) annotation (Line(points={{82,82},{62,82},
                {62,50},{35,50}}, color={0,0,127}));
        connect(I_qref.y, Vq_ref.u_s)
          annotation (Line(points={{105,88},{128,88}}, color={0,0,127}));
        connect(division4.u1, to_wsl.y)
          annotation (Line(points={{110,6},{49,6}},                color={0,0,127}));
        connect(division4.u2, Psi_est.y) annotation (Line(points={{110,-6},{62,
                -6},{62,50},{35,50}},     color={0,0,127}));
        connect(add.u2, division4.y) annotation (Line(points={{168,20},{158,20},
                {158,0},{133,0}},
                          color={0,0,127}));
        connect(add.u1, w_e.y) annotation (Line(points={{168,32},{0,32},{0,12},
                {-45,12}},        color={0,0,127}));
        connect(integrator.u, add.y)
          annotation (Line(points={{204,26},{191,26}}, color={0,0,127}));
        connect(integrator.y, fromDQ.phi)
          annotation (Line(points={{227,26},{232,26},{232,108}}, color={0,0,127}));
        connect(to_wsl.u, Vq_ref.u_m) annotation (Line(points={{26,6},{26,-34},
                {140,-34},{140,76}}, color={0,0,127}));
        connect(demux1.y[1], Vd_ref.u_m) annotation (Line(points={{-25.5,-38},{
                -25.5,38},{-22,38},{-22,114}}, color={0,0,127}));
        connect(demux1.y[2], Vq_ref.u_m) annotation (Line(points={{-18.5,-38},{
                32,-38},{32,-34},{140,-34},{140,76}}, color={0,0,127}));
        connect(toDQ.phi, fromDQ.phi) annotation (Line(points={{-10,-84},{232,
                -84},{232,108}}, color={0,0,127}));
        connect(Flux_Ref.y, Vd_ref.u_s)
          annotation (Line(points={{-75,126},{-34,126}}, color={0,0,127}));
        connect(Torque_ref.u_m, Speed) annotation (Line(points={{0,82},{-78,12},
                {-80,12},{-80,-92},{-100,-92}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-120},
                  {380,180}}), graphics={Text(
                extent={{50,36},{316,-24}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={215,215,215},
                fillPattern=FillPattern.None,
                textStyle={TextStyle.Bold},
                textString="PI Speed Control
"),       Rectangle(
                extent={{-100,100},{380,-120}},
                lineColor={0,0,0},
                lineThickness=1,
                fillColor={215,215,215},
                fillPattern=FillPattern.None)}),
                                           Diagram(coordinateSystem(
                preserveAspectRatio=false, extent={{-100,-120},{380,180}})),
          experiment(
            StopTime=1000,
            __Dymola_NumberOfIntervals=500000,
            Tolerance=1e-05));
      end SpeedController_IM;

      model Slip_Calc
        parameter Real Tr;

        Modelica.Blocks.Interfaces.RealInput Id annotation (Placement(transformation(
              origin={-100,90},
              extent={{20,-20},{-20,20}},
              rotation=180), iconTransformation(
              extent={{20,-20},{-20,20}},
              rotation=180,
              origin={-80,82})));
        Modelica.Blocks.Interfaces.RealInput Iq annotation (Placement(transformation(
              origin={-100,-90},
              extent={{20,-20},{-20,20}},
              rotation=180), iconTransformation(
              extent={{20,-20},{-20,20}},
              rotation=180,
              origin={-80,-80})));
        Modelica.Blocks.Math.Gain gain(k=Tr)
          annotation (Placement(transformation(extent={{-56,-64},{-36,-44}})));
        Modelica.Blocks.Continuous.FirstOrder firstOrder(T=Tr)
          annotation (Placement(transformation(extent={{-56,44},{-36,64}})));
        Modelica.Blocks.Math.Division division
          annotation (Placement(transformation(extent={{10,-2},{30,18}})));
        Modelica.Blocks.Continuous.Integrator integrator
          annotation (Placement(transformation(extent={{42,-2},{62,18}})));
        Modelica.Blocks.Interfaces.RealOutput th_s
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
      equation
        connect(firstOrder.u, Id) annotation (Line(points={{-58,54},{-68,54},{
                -68,90},{-100,90}}, color={0,0,127}));
        connect(gain.u, Iq) annotation (Line(points={{-58,-54},{-70,-54},{-70,
                -90},{-100,-90}}, color={0,0,127}));
        connect(division.u1, firstOrder.y) annotation (Line(points={{8,14},{-6,
                14},{-6,54},{-35,54}}, color={0,0,127}));
        connect(division.u2, gain.y) annotation (Line(points={{8,2},{-6,2},{-6,
                -54},{-35,-54}}, color={0,0,127}));
        connect(division.y, integrator.u)
          annotation (Line(points={{31,8},{40,8}}, color={0,0,127}));
        connect(integrator.y, th_s) annotation (Line(points={{63,8},{84,8},{84,
                0},{110,0}}, color={0,0,127}));
      end Slip_Calc;
    end PMSM;

    package IM
      model VfController

        Modelica.Electrical.Machines.Utilities.VfController vfController(
          final m=3,
          VNominal=VNominal,
          fNominal=fNominal,
          EconomyMode=false) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-94,-26})));
        Modelica.Blocks.Math.Add add(k2=-1)
          annotation (Placement(transformation(extent={{-246,18},{-226,38}})));
        Modelica.Blocks.Math.Division division
          annotation (Placement(transformation(extent={{2,-42},{22,-22}})));
        Modelica.Blocks.Routing.DeMultiplex3 deMultiplex3_1
          annotation (Placement(transformation(extent={{-80,-36},{-60,-16}})));
        Modelica.Blocks.Math.Division division1
          annotation (Placement(transformation(extent={{2,-16},{22,4}})));
        Modelica.Blocks.Math.Division division2
          annotation (Placement(transformation(extent={{2,10},{22,30}})));
        Modelica.Blocks.Interfaces.RealInput w_ref annotation (Placement(
              transformation(rotation=0, extent={{-310,46},{-290,66}})));
        Modelica.Blocks.Interfaces.RealInput w_m annotation (Placement(
              transformation(rotation=0, extent={{-310,-6},{-290,14}})));
        Modelica.Blocks.Interfaces.RealOutput m_c annotation (Placement(
              transformation(
              rotation=90,
              extent={{-10,-10},{10,10}},
              origin={-40,150})));
        Modelica.Blocks.Interfaces.RealOutput m_b annotation (Placement(
              transformation(
              rotation=90,
              extent={{-10,-10},{10,10}},
              origin={-80,150})));
        Modelica.Blocks.Interfaces.RealInput V_DC annotation (Placement(
              transformation(
              rotation=270,
              extent={{-10,-10},{10,10}},
              origin={4,150})));
        Modelica.Blocks.Interfaces.RealOutput m_a annotation (Placement(
              transformation(
              rotation=90,
              extent={{-10,-10},{10,10}},
              origin={-120,150})));
        parameter Modelica.SIunits.Time T=0.1 "Time Constant (T>0 required)";
        parameter Modelica.SIunits.Voltage VNominal=600
          "Nominal RMS voltage per phase";
        parameter Modelica.SIunits.Frequency fNominal=400 "Nominal frequency";

        Modelica.Blocks.Nonlinear.Limiter limiter(uMax=0.99, uMin=-0.99)
                                                                   annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-120,106})));
        Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=0.99, uMin=-0.99)
                                                                    annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-40,108})));
        Modelica.Blocks.Nonlinear.Limiter limiter2(uMax=0.99, uMin=-0.99)
                                                                    annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-80,108})));
        Modelica.Blocks.Math.Max max annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={10,92})));
        Modelica.Blocks.Sources.Constant const(k=1) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={16,126})));
        Modelica.Blocks.Math.Gain gain(k=1/6.28)
          annotation (Placement(transformation(extent={{-118,-30},{-110,-22}})));
        Modelica.Blocks.Sources.Constant const1(k=235) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-22,64})));
        Modelica.Blocks.Continuous.FirstOrder firstOrder(T=0.01)
                                                                annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-264,4})));
        Modelica.Blocks.Continuous.PI PI1(k=1, T=T)
          annotation (Placement(transformation(extent={{-170,-36},{-150,-16}})));
        Modelica.Blocks.Continuous.PI PI2(k=1, T=T)
          annotation (Placement(transformation(extent={{-142,-36},{-122,-16}})));
        Components.Generators.Controls.K_Sch k_Sch(
          k1=10,
          k2=1,
          t=5)
          annotation (Placement(transformation(extent={{-208,-16},{-188,4}})));
      equation

        connect(deMultiplex3_1.u, vfController.y) annotation (Line(points={{-82,-26},
                {-83,-26}},                        color={0,0,127}));
        connect(division1.u2, division2.u2) annotation (Line(points={{0,-12},{-14,
                -12},{-14,14},{0,14}}, color={0,0,127}));
        connect(division.u2, division2.u2) annotation (Line(points={{0,-38},{-14,
                -38},{-14,14},{0,14}}, color={0,0,127}));
        connect(division2.u1, deMultiplex3_1.y1[1]) annotation (Line(points={{0,26},{
                -18,26},{-18,-19},{-59,-19}},    color={0,0,127}));
        connect(division1.u1, deMultiplex3_1.y2[1]) annotation (Line(points={{0,0},{
                -18,0},{-18,-26},{-59,-26}},color={0,0,127}));
        connect(division.u1, deMultiplex3_1.y3[1]) annotation (Line(points={{0,-26},
                {-16,-26},{-16,-33},{-59,-33}},  color={0,0,127}));
        connect(limiter.y, m_a)
          annotation (Line(points={{-120,117},{-120,150}}, color={0,0,127}));
        connect(limiter1.y, m_c) annotation (Line(points={{-40,119},{-40,150},{
                -40,150}}, color={0,0,127}));
        connect(limiter2.y, m_b) annotation (Line(points={{-80,119},{-80,150},{
                -80,150}}, color={0,0,127}));
        connect(limiter.u, division2.y) annotation (Line(points={{-120,94},{-120,
                20},{23,20}}, color={0,0,127}));
        connect(limiter2.u, division1.y)
          annotation (Line(points={{-80,96},{-80,-6},{23,-6}}, color={0,0,127}));
        connect(division.y, limiter1.u) annotation (Line(points={{23,-32},{-40,
                -32},{-40,96}},    color={0,0,127}));
        connect(max.u2, V_DC)
          annotation (Line(points={{4,104},{4,150}}, color={0,0,127}));
        connect(const.y, max.u1)
          annotation (Line(points={{16,115},{16,104}}, color={0,0,127}));
        connect(gain.y, vfController.u)
          annotation (Line(points={{-109.6,-26},{-106,-26}},
                                                           color={0,0,127}));
        connect(max.y, division2.u2)
          annotation (Line(points={{10,81},{0,81},{0,14}}, color={0,0,127}));
        connect(firstOrder.y, add.u2) annotation (Line(points={{-253,4},{-248,4},
                {-248,22}}, color={0,0,127}));
        connect(firstOrder.u, w_m)
          annotation (Line(points={{-276,4},{-300,4}}, color={0,0,127}));
        connect(add.u1, w_ref) annotation (Line(points={{-248,34},{-264,34},{-264,
                56},{-300,56}}, color={0,0,127}));
        connect(PI2.u, PI1.y)
          annotation (Line(points={{-144,-26},{-149,-26}}, color={0,0,127}));
        connect(PI2.y, gain.u)
          annotation (Line(points={{-121,-26},{-118.8,-26}},
                                                           color={0,0,127}));
        connect(k_Sch.y, PI1.u) annotation (Line(points={{-187,-6},{-180,-6},{
                -180,-26},{-172,-26}}, color={0,0,127}));
        connect(k_Sch.u, add.y) annotation (Line(points={{-208,-6},{-218,-6},{
                -218,28},{-225,28}}, color={0,0,127}));
        annotation (Diagram(coordinateSystem(extent={{-300,-60},{180,150}})),Icon(
              coordinateSystem(extent={{-300,-60},{180,150}})),
          experiment(
            StopTime=1000,
            Interval=0.001,
            Tolerance=1e-05,
            __Dymola_Algorithm="Dassl"));
      end VfController;
    end IM;
  end Controls;

  package Components
    package Conversion
      package Switches
        model Diode_Snubber
          parameter Modelica.SIunits.Resistance Rcond=1e-5
            "Forward state-on differential resistance (closed resistance)";
          parameter Modelica.SIunits.Voltage Vt=0.8 "Forward threshold voltage";
          parameter Modelica.SIunits.Conductance Gof=1e-5
            "Backward state-off conductance (opened conductance)";
          parameter Modelica.SIunits.Resistance R1=1e-3 "Snubber Resistance";
          parameter Modelica.SIunits.Capacitance C1=1e-6 "SnubberCapacitance";
          Modelica.Electrical.MultiPhase.Basic.Resistor resistor(R={R1,R1,R1}) annotation (
             Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={28,76})));
          Modelica.Electrical.MultiPhase.Basic.Capacitor capacitor(C={C1,C1,C1})
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={28,44})));
          Modelica.Electrical.MultiPhase.Interfaces.PositivePlug positivePlug
            annotation (Placement(transformation(extent={{0,132},{20,152}})));
          Modelica.Electrical.MultiPhase.Interfaces.NegativePlug negativePlug
            annotation (Placement(transformation(extent={{2,-30},{22,-10}}),
                iconTransformation(extent={{2,-30},{22,-10}})));
          Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode1(
            Ron={Rcond,Rcond,Rcond},
            Goff={Gof,Gof,Gof},
            Vknee={Vt,Vt,Vt}) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-2,74})));
        equation
          connect(capacitor.plug_n, resistor.plug_n)
            annotation (Line(points={{28,54},{28,66}}, color={0,0,255}));
          connect(diode1.plug_p, positivePlug) annotation (Line(points={{-2,84},
                  {10,84},{10,142}}, color={0,0,255}));
          connect(resistor.plug_p, positivePlug) annotation (Line(points={{28,
                  86},{10,86},{10,142}}, color={0,0,255}));
          connect(capacitor.plug_p, diode1.plug_n) annotation (Line(points={{28,
                  34},{14,34},{14,32},{-2,32},{-2,64}}, color={0,0,255}));
          connect(negativePlug, diode1.plug_n) annotation (Line(points={{12,-20},
                  {12,32},{-2,32},{-2,64}}, color={0,0,255}));
          annotation (Diagram(coordinateSystem(extent={{-80,-20},{100,140}})), Icon(
                coordinateSystem(extent={{-80,-20},{100,140}}), graphics={
                Polygon(
                  points={{50,9.00308e-15},{-38,64},{-38,-72},{50,9.00308e-15}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  origin={12,44},
                  rotation=270),
                Line(points={{-40,92},{60,92}},
                                             color={0,0,255}),
                Line(points={{12,138},{12,-20}},color={0,0,255}),
                Text(
                  extent={{-138,134},{162,94}},
                  textString="%name",
                  lineColor={0,0,255})}));
        end Diode_Snubber;

        model Diode_noSnubber
          parameter Modelica.SIunits.Resistance Rcond=1e-5
            "Forward state-on differential resistance (closed resistance)";
          parameter Modelica.SIunits.Voltage Vt=0.8 "Forward threshold voltage";
          parameter Modelica.SIunits.Conductance Gof=1e-5
            "Backward state-off conductance (opened conductance)";
          Modelica.Electrical.MultiPhase.Interfaces.PositivePlug positivePlug
            annotation (Placement(transformation(extent={{0,132},{20,152}})));
          Modelica.Electrical.MultiPhase.Interfaces.NegativePlug negativePlug
            annotation (Placement(transformation(extent={{2,-30},{22,-10}}),
                iconTransformation(extent={{2,-30},{22,-10}})));
          Modelica.Electrical.MultiPhase.Ideal.IdealDiode diode1(
            Ron={Rcond,Rcond,Rcond},
            Goff={Gof,Gof,Gof},
            Vknee={Vt,Vt,Vt}) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={10,72})));
        equation
          connect(diode1.plug_p, positivePlug) annotation (Line(points={{10,82},
                  {10,142}},         color={0,0,255}));
          connect(negativePlug, diode1.plug_n) annotation (Line(points={{12,-20},
                  {12,32},{10,32},{10,62}}, color={0,0,255}));
          annotation (Diagram(coordinateSystem(extent={{-80,-20},{100,140}})), Icon(
                coordinateSystem(extent={{-80,-20},{100,140}}), graphics={
                Polygon(
                  points={{50,9.00308e-15},{-38,64},{-38,-72},{50,9.00308e-15}},
                  lineColor={0,0,255},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid,
                  origin={12,44},
                  rotation=270),
                Line(points={{-40,92},{60,92}},
                                             color={0,0,255}),
                Line(points={{12,138},{12,-20}},color={0,0,255}),
                Text(
                  extent={{-138,134},{162,94}},
                  textString="%name",
                  lineColor={0,0,255})}));
        end Diode_noSnubber;

      end Switches;

      package ACDC

        model Rectifier
          Modelica.Electrical.MultiPhase.Basic.Star star(m=3) annotation (Placement(
                transformation(
                origin={-24,66},
                extent={{-10,10},{10,-10}},
                rotation=0)));
          parameter Modelica.SIunits.Resistance Rcond=1e-5
            "Forward state-on differential resistance (closed resistance)";
          parameter Modelica.SIunits.Voltage Vt=0.8 "Forward threshold voltage";
          parameter Modelica.SIunits.Conductance Gof=1e-5
            "Backward state-off conductance (opened conductance)";
          Modelica.Electrical.MultiPhase.Basic.Star star1(m=3)
                                                              annotation (Placement(
                transformation(
                origin={-16,-6},
                extent={{-10,10},{10,-10}},
                rotation=0)));
          Modelica.Electrical.MultiPhase.Interfaces.PositivePlug positivePlug
            annotation (Placement(transformation(extent={{-200,-10},{-180,10}}),
                iconTransformation(extent={{-200,-10},{-180,10}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_p
            annotation (Placement(transformation(extent={{40,80},{60,100}}),
                iconTransformation(extent={{40,80},{60,100}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_n
            annotation (Placement(transformation(extent={{40,-80},{60,-60}}),
                iconTransformation(extent={{40,-80},{60,-60}})));
          Switches.Diode_Snubber   diode_Snubber1  annotation (Placement(
                transformation(
                extent={{-9,-8},{9,8}},
                rotation=90,
                origin={-71,66})));
          Switches.Diode_Snubber   diode_Snubber    annotation (Placement(
                transformation(
                extent={{-9,-8},{9,8}},
                rotation=270,
                origin={-67,-6})));
        equation
          connect(pin_p, star.pin_n)
            annotation (Line(points={{50,90},{18,90},{18,66},{-14,66}},
                                                        color={0,0,255}));
          connect(pin_n, star1.pin_n)
            annotation (Line(points={{50,-70},{22,-70},{22,-6},{-6,-6}},
                                                       color={0,0,255}));
          connect(diode_Snubber1.negativePlug, star.plug_p) annotation (Line(
                points={{-63,66.2},{-63.5,66.2},{-63.5,66},{-34,66}}, color={0,
                  0,255}));
          connect(diode_Snubber1.positivePlug, positivePlug) annotation (Line(
                points={{-79.2,66},{-84,66},{-84,-6},{-129.6,-6},{-129.6,0},{-190,
                  0}}, color={0,0,255}));
          connect(diode_Snubber.negativePlug, positivePlug) annotation (Line(
                points={{-75,-6.2},{-84,-6},{-129.6,-6},{-129.6,0},{-190,0}},
                color={0,0,255}));
          connect(diode_Snubber.positivePlug, star1.plug_p)
            annotation (Line(points={{-58.8,-6},{-26,-6}}, color={0,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-180,
                    -80},{40,100}}), graphics={
                Line(
                  points={{-148,-24},{6,-24},{-74,80},{-148,-24}},
                  color={0,0,0},
                  thickness=1),
                Line(
                  points={{-128,-38},{-18,-38}},
                  color={0,0,0},
                  thickness=1),
                Line(
                  points={{-74,80},{-74,100}},
                  color={0,0,0},
                  thickness=1),
                Line(
                  points={{-72,-24},{-72,-80}},
                  color={0,0,0},
                  thickness=1),
                Line(
                  points={{-180,100},{-180,-80},{40,-80},{40,100},{-180,100}},
                  color={0,0,0},
                  thickness=1),
                Text(
                  extent={{-108,114},{-36,90}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  textString="%name
",                textStyle={TextStyle.Bold})}),                         Diagram(
                coordinateSystem(preserveAspectRatio=false, extent={{-180,-80},
                    {40,100}})),
            experiment(StopTime=10, __Dymola_NumberOfIntervals=5000));
        end Rectifier;

        model Ret_AVG_Simulink
          Modelica.Electrical.Analog.Interfaces.PositivePin DC_p
            annotation (Placement(transformation(extent={{80,60},{100,80}}),
                iconTransformation(extent={{80,60},{100,80}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin DC_n
            annotation (Placement(transformation(extent={{76,-80},{96,-60}}),
                iconTransformation(extent={{76,-80},{96,-60}})));
          Modelica.Electrical.MultiPhase.Interfaces.PositivePlug AC
            annotation (Placement(transformation(extent={{-100,-10},{-80,10}}),
                iconTransformation(extent={{-100,-10},{-80,10}})));
          Modelica.SIunits.Voltage va,vb,vc,vab,vbc,vca,vref,vrms,vdc;
          Modelica.SIunits.Resistance rac,R_fixed;
          Modelica.SIunits.Power Pdc;
          parameter Modelica.SIunits.Power P_fixed;
          parameter Modelica.SIunits.Voltage V_rated;


          Modelica.Electrical.Analog.Interfaces.PositivePin v_ref
            annotation (Placement(transformation(extent={{78,-12},{98,8}}),
                iconTransformation(extent={{82,-10},{102,10}})));
        equation
          va = AC.pin[1].v;
          vb = AC.pin[2].v;
          vc = AC.pin[3].v;
          vab = va-vb;
          vbc = vb-vc;
          vca = vc-va;

          vref = (va+vb+vc)/3;

          vrms = max(sqrt((vab^2+vbc^2+vca^2)/3),1e-18);

          vdc = 3*sqrt(2)*vrms/Modelica.Constants.pi;

          DC_p.v = vref + vdc/2;
          DC_n.v = vref - vdc/2;

          R_fixed = V_rated^2/P_fixed;
          Pdc = DC_p.v*DC_p.i+DC_n.v*DC_n.i;
          rac = vrms^2/(Pdc+(vrms^2/R_fixed));

          AC.pin[1].i = (va-vref)/rac;
          AC.pin[2].i = (vb-vref)/rac;
          AC.pin[3].i = (vc-vref)/rac;
          vref = v_ref.v;
                annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,
                    -80},{80,80}}), graphics={
                Rectangle(
                  extent={{-80,80},{80,-80}},
                  lineColor={28,108,200},
                  fillColor={197,197,197},
                  fillPattern=FillPattern.Solid),
                Line(
                  points={{-80,80},{-80,-80},{80,-80},{80,80},{-80,80}},
                  color={0,0,0},
                  thickness=1),
                Line(
                  points={{-80,-80},{80,78}},
                  color={0,0,0},
                  thickness=1),
                Text(
                  extent={{-66,58},{6,28}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={197,197,197},
                  fillPattern=FillPattern.Solid,
                  textString="AC"),
                Text(
                  extent={{-2,-32},{60,-58}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  fillColor={197,197,197},
                  fillPattern=FillPattern.Solid,
                  textString="DC")}),                                          Diagram(
                coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},{80,80}})));
        end Ret_AVG_Simulink;
      end ACDC;

      package DCAC
        model AvgInverter
          Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=180,
                origin={24,56})));
          Modelica.Electrical.Analog.Sources.SignalCurrent Ina
            annotation (Placement(transformation(extent={{-30,10},{-10,30}})));
          Modelica.Electrical.Analog.Sources.SignalCurrent Ipa
            annotation (Placement(transformation(extent={{-32,58},{-12,78}})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
            annotation (Placement(transformation(extent={{52,46},{72,66}})));
          SourceGains sourceGains annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={38,34})));
          Modelica.Electrical.Analog.Basic.Ground ground1
            annotation (Placement(transformation(extent={{-34,34},{-14,54}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-46,50})));
          Modelica.Electrical.MultiPhase.Interfaces.PositivePlug positivePlug
            annotation (Placement(transformation(extent={{140,-74},{160,-54}}),
                iconTransformation(extent={{140,-74},{160,-54}})));
          .AircraftPowerSystem.Interfaces.multiphtoabc multiphtoabc annotation (
             Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={118,0})));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_p annotation (
              Placement(transformation(extent={{-140,62},{-120,82}}),
                iconTransformation(extent={{-140,62},{-120,82}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_n annotation (
              Placement(transformation(extent={{-140,-24},{-120,-4}}),
                iconTransformation(extent={{-140,-24},{-120,-4}})));
          Modelica.Electrical.Analog.Interfaces.PositivePin pin_p1 annotation (
              Placement(transformation(extent={{-140,-120},{-120,-100}}),
                iconTransformation(extent={{-140,-120},{-120,-100}})));
          Modelica.Electrical.Analog.Interfaces.NegativePin pin_n1 annotation (
              Placement(transformation(extent={{-140,-208},{-120,-188}}),
                iconTransformation(extent={{-140,-208},{-120,-188}})));
          Modelica.Electrical.Analog.Basic.Ground ground2 annotation (Placement(
                transformation(extent={{-100,-40},{-80,-20}})));
          Modelica.Electrical.Analog.Sources.SignalCurrent Ina1
            annotation (Placement(transformation(extent={{-28,-82},{-8,-62}})));
          Modelica.Electrical.Analog.Sources.SignalCurrent Ipa1 annotation (
              Placement(transformation(extent={{-30,-36},{-10,-16}})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor1
            annotation (Placement(transformation(extent={{54,-48},{74,-28}})));
          SourceGains sourceGains1 annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={40,-60})));
          Modelica.Electrical.Analog.Basic.Ground ground3 annotation (Placement(
                transformation(extent={{-32,-60},{-12,-40}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor1
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-44,-44})));
          Modelica.Electrical.Analog.Sources.SignalCurrent Ina2 annotation (
              Placement(transformation(extent={{-28,-188},{-8,-168}})));
          Modelica.Electrical.Analog.Sources.SignalCurrent Ipa2 annotation (
              Placement(transformation(extent={{-30,-142},{-10,-122}})));
          Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor2
            annotation (Placement(transformation(extent={{54,-154},{74,-134}})));
          SourceGains sourceGains2 annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={40,-166})));
          Modelica.Electrical.Analog.Basic.Ground ground4 annotation (Placement(
                transformation(extent={{-32,-166},{-12,-146}})));
          Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor2
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={-44,-150})));
          Modelica.Blocks.Interfaces.RealInput ma "Phase A Modulation Signal" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=270,
                origin={-102,116}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=270,
                origin={-76,82})));
          Modelica.Blocks.Interfaces.RealInput mc "Phase B Modulation Signal" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=270,
                origin={116,118}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=270,
                origin={120,82})));
          Modelica.Blocks.Interfaces.RealInput mb "Phase C Modulation Signal" annotation (Placement(
                transformation(
                extent={{-20,-20},{20,20}},
                rotation=270,
                origin={2,114}), iconTransformation(
                extent={{-20,-20},{20,20}},
                rotation=270,
                origin={20,82})));
          Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage1
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=180,
                origin={26,-32})));
          Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage2
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=180,
                origin={32,-126})));
        equation
          connect(sourceGains.Vt, signalVoltage.v) annotation (Line(points={{27,42.2},
                  {27,44},{24,44}},       color={0,0,127}));
          connect(sourceGains.I_n, Ina.i)
            annotation (Line(points={{27,34},{4,34},{4,32},{-20,32}},
                                                        color={0,0,127}));
          connect(sourceGains.I_p, Ipa.i) annotation (Line(points={{27,26},{6,
                  26},{6,80},{-22,80}}, color={0,0,127}));
          connect(voltageSensor.p, Ipa.p) annotation (Line(points={{-46,60},{
                  -46,68},{-32,68}}, color={0,0,255}));
          connect(voltageSensor.n, Ina.p) annotation (Line(points={{-46,40},{
                  -46,20},{-30,20}}, color={0,0,255}));
          connect(voltageSensor.v, sourceGains.Vdc) annotation (Line(points={{
                  -57,50},{-58,50},{-58,39.8},{48,39.8}}, color={0,0,127}));
          connect(currentSensor.i, sourceGains.i) annotation (Line(points={{62,
                  45},{60,45},{60,34},{48,34}}, color={0,0,127}));
          connect(multiphtoabc.m, positivePlug) annotation (Line(points={{128.4,
                  -1.22125e-15},{127.8,-1.22125e-15},{127.8,-64},{150,-64}},
                                                             color={0,0,255}));
          connect(pin_p, pin_p) annotation (Line(points={{-130,72},{-114,72},{
                  -114,72},{-130,72}}, color={0,0,255}));
          connect(pin_p, Ipa.p)
            annotation (Line(points={{-130,72},{-82,72},{-82,68},{-32,68}},
                                                          color={0,0,255}));
          connect(pin_p1, pin_n) annotation (Line(points={{-130,-110},{-130,-64},
                  {-130,-64},{-130,-14}},
                color={0,0,255}));
          connect(ground2.p, pin_n) annotation (Line(points={{-90,-20},{-112,
                  -20},{-112,-22},{-130,-22},{-130,-14}}, color={0,0,255}));
          connect(pin_n1, Ina.p) annotation (Line(points={{-130,-198},{-130,20},
                  {-30,20}}, color={0,0,255}));
          connect(sourceGains1.I_n, Ina1.i)
            annotation (Line(points={{29,-60},{-18,-60}}, color={0,0,127}));
          connect(sourceGains1.I_p, Ipa1.i) annotation (Line(points={{29,-68},{
                  8,-68},{8,-14},{-20,-14}}, color={0,0,127}));
          connect(voltageSensor1.p, Ipa1.p) annotation (Line(points={{-44,-34},
                  {-44,-26},{-30,-26}}, color={0,0,255}));
          connect(voltageSensor1.n, Ina1.p) annotation (Line(points={{-44,-54},
                  {-44,-72},{-28,-72}}, color={0,0,255}));
          connect(voltageSensor1.v, sourceGains1.Vdc) annotation (Line(points={
                  {-55,-44},{-56,-44},{-56,-54.2},{50,-54.2}}, color={0,0,127}));
          connect(currentSensor1.i, sourceGains1.i) annotation (Line(points={{
                  64,-49},{62,-49},{62,-60},{50,-60}}, color={0,0,127}));
          connect(pin_p, Ipa1.p) annotation (Line(points={{-130,72},{-74,72},{
                  -74,-26},{-30,-26}}, color={0,0,255}));
          connect(pin_n1, Ina1.p) annotation (Line(points={{-130,-198},{-28,
                  -198},{-28,-72}}, color={0,0,255}));
          connect(pin_n1, Ina.p) annotation (Line(points={{-130,-198},{-30,-198},
                  {-30,20}}, color={0,0,255}));
          connect(sourceGains2.I_n, Ina2.i)
            annotation (Line(points={{29,-166},{-18,-166}}, color={0,0,127}));
          connect(sourceGains2.I_p, Ipa2.i) annotation (Line(points={{29,-174},
                  {8,-174},{8,-120},{-20,-120}}, color={0,0,127}));
          connect(voltageSensor2.p, Ipa2.p) annotation (Line(points={{-44,-140},
                  {-44,-132},{-30,-132}}, color={0,0,255}));
          connect(voltageSensor2.n, Ina2.p) annotation (Line(points={{-44,-160},
                  {-44,-178},{-28,-178}}, color={0,0,255}));
          connect(voltageSensor2.v, sourceGains2.Vdc) annotation (Line(points={
                  {-55,-150},{-56,-150},{-56,-160.2},{50,-160.2}}, color={0,0,
                  127}));
          connect(currentSensor2.i, sourceGains2.i) annotation (Line(points={{
                  64,-155},{62,-155},{62,-166},{50,-166}}, color={0,0,127}));
          connect(pin_p, Ipa2.p) annotation (Line(points={{-130,72},{-74,72},{
                  -74,-132},{-30,-132}}, color={0,0,255}));
          connect(pin_n1, Ina2.p) annotation (Line(points={{-130,-198},{-28,
                  -198},{-28,-178}}, color={0,0,255}));
          connect(ma, sourceGains.m) annotation (Line(points={{-102,116},{-28,
                  116},{-28,26.6},{48,26.6}}, color={0,0,127}));
          connect(mb, sourceGains1.m) annotation (Line(points={{2,114},{2,19},{
                  50,19},{50,-67.4}}, color={0,0,127}));
          connect(mc, sourceGains2.m) annotation (Line(points={{116,118},{122,
                  118},{122,-173.4},{50,-173.4}}, color={0,0,127}));
          connect(multiphtoabc.a, currentSensor.n) annotation (Line(points={{
                  107.6,-9.6},{107.6,-10.8},{72,-10.8},{72,56}}, color={0,0,255}));
          connect(multiphtoabc.b, currentSensor1.n) annotation (Line(points={{
                  107.6,-0.4},{107.6,-1.2},{74,-1.2},{74,-38}}, color={0,0,255}));
          connect(multiphtoabc.c, currentSensor2.n) annotation (Line(points={{
                  107.6,9.6},{98,9.6},{98,-144},{74,-144}}, color={0,0,255}));
          connect(signalVoltage.n, Ipa.n) annotation (Line(points={{14,56},{2,
                  56},{2,68},{-12,68}}, color={0,0,255}));
          connect(Ina.n, signalVoltage.n) annotation (Line(points={{-10,20},{2,
                  20},{2,56},{14,56}}, color={0,0,255}));
          connect(signalVoltage.p, currentSensor.p)
            annotation (Line(points={{34,56},{52,56}}, color={0,0,255}));
          connect(signalVoltage1.n, Ipa1.n) annotation (Line(points={{16,-32},{
                  4,-32},{4,-26},{-10,-26}}, color={0,0,255}));
          connect(signalVoltage1.n, Ina1.n) annotation (Line(points={{16,-32},{
                  4,-32},{4,-72},{-8,-72}}, color={0,0,255}));
          connect(signalVoltage1.p, currentSensor1.p) annotation (Line(points={
                  {36,-32},{46,-32},{46,-38},{54,-38}}, color={0,0,255}));
          connect(signalVoltage1.v, sourceGains1.Vt) annotation (Line(points={{
                  26,-44},{29,-44},{29,-51.8}}, color={0,0,127}));
          connect(ground1.p, Ipa.n) annotation (Line(points={{-24,54},{2,54},{2,
                  68},{-12,68}}, color={0,0,255}));
          connect(ground3.p, Ina1.n) annotation (Line(points={{-22,-40},{4,-40},
                  {4,-72},{-8,-72}}, color={0,0,255}));
          connect(Ipa2.n, Ina2.n) annotation (Line(points={{-10,-132},{-10,-156},
                  {-8,-156},{-8,-178}}, color={0,0,255}));
          connect(ground4.p, Ina2.n) annotation (Line(points={{-22,-146},{-10,
                  -146},{-10,-156},{-8,-156},{-8,-178}}, color={0,0,255}));
          connect(signalVoltage2.n, Ina2.n) annotation (Line(points={{22,-126},
                  {-10,-126},{-10,-156},{-8,-156},{-8,-178}}, color={0,0,255}));
          connect(signalVoltage2.p, currentSensor2.p) annotation (Line(points={
                  {42,-126},{48,-126},{48,-144},{54,-144}}, color={0,0,255}));
          connect(sourceGains2.Vt, signalVoltage2.v) annotation (Line(points={{
                  29,-157.8},{29,-148.9},{32,-148.9},{32,-138}}, color={0,0,127}));
          annotation (
            Icon(coordinateSystem(preserveAspectRatio=false, extent={{-120,-220},
                    {140,100}}), graphics={
                Line(
                  points={{-118,102},{-118,-218},{140,-218},{140,102},{-118,102}},
                  color={0,0,0},
                  thickness=1),
                Line(
                  points={{140,100},{-114,-216},{-116,-218}},
                  color={0,0,0},
                  thickness=1),
                Text(
                  extent={{-96,28},{12,-20}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  textString="DC"),
                Text(
                  extent={{0,-124},{108,-172}},
                  lineColor={0,0,0},
                  lineThickness=1,
                  textString="AC"),
                Text(
                  extent={{-94,52},{-58,34}},
                  lineColor={238,46,47},
                  textString="A",
                  textStyle={TextStyle.Bold}),
                Text(
                  extent={{2,48},{38,30}},
                  lineColor={238,46,47},
                  textStyle={TextStyle.Bold},
                  textString="B"),
                Text(
                  extent={{102,50},{138,32}},
                  lineColor={238,46,47},
                  textStyle={TextStyle.Bold},
                  textString="C")}),
            Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,
                    -220},{140,100}})),
            experiment(StopTime=100, __Dymola_NumberOfIntervals=50000),
            Documentation(info="<html>
<p>Averaged Inverter Model</p>
<p>Inputs ma, mb, mc modulate the controlled sources.</p>
<p>Modulation signals must be between -1 and 1 (no error will be tiven for higher values).</p>
<p>Modulation signal of 1 generates voltage equal to one of the input terminals of the converter.</p>
</html>"));
        end AvgInverter;

        model SourceGains
          Modelica.Blocks.Interfaces.RealInput m "Voltage Modulation"
            annotation (Placement(transformation(extent={{-120,54},{-80,94}})));
          Modelica.Blocks.Interfaces.RealInput i "Output Current"
            annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
          Modelica.Blocks.Interfaces.RealOutput I_p "Positive Branch Current"
            annotation (Placement(transformation(extent={{100,70},{120,90}})));
          Modelica.Blocks.Interfaces.RealOutput I_n "Negative Branch Current"
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          Modelica.Blocks.Interfaces.RealOutput Vt "Output Voltage"
            annotation (Placement(transformation(extent={{100,-92},{120,-72}})));
          Modelica.Blocks.Interfaces.RealInput Vdc "DC Voltage between Terminals"
            annotation (Placement(transformation(extent={{-120,-78},{-80,-38}})));
        equation
          I_p = ((1+m)/2)*i;
          I_n = ((1-m)/2)*i;
          Vt = m*Vdc/2;
          annotation (Documentation(info="<html>
<p>Averaged Inverter Curent and Voltage Command generator.</p>
</html>"));
        end SourceGains;
      end DCAC;
    end Conversion;

    package Generators
      model SG
        Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
          smee(
          fsNominal=Data.fsNominal,
          Rs=Data.Rs,
          TsRef=Data.TsRef,
          Lssigma=Data.Lssigma,
          phiMechanical(fixed=false),
          wMechanical(fixed=false),
          Lmd=Data.Lmd,
          Lmq=Data.Lmq,
          Lrsigmad=Data.Lrsigmad,
          Lrsigmaq=Data.Lrsigmaq,
          Rrd=Data.Rrd,
          Rrq=Data.Rrq,
          TrRef=Data.TrRef,
          VsNominal=Data.VsNominal,
          IeOpenCircuit=Data.IeOpenCircuit,
          Re=Data.Re,
          TeRef=Data.TeRef,
          sigmae=Data.sigmae,
          p=Data.Poles,
          Jr=1.5,
          Js=0.29,
          useDamperCage=true,
          statorCoreParameters(VRef=115),
          strayLoadParameters(IRef=100),
          brushParameters(ILinear=0.01),
          TsOperational=293.15,
          alpha20s=Data.alpha20s,
          TrOperational=293.15,
          alpha20r=Data.alpha20r,
          alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TeOperational=293.15)
          annotation (Placement(transformation(extent={{-14,-24},{6,-4}})));

        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle
          rotorDisplacementAngle(p=Data.Poles)
                                      annotation (Placement(transformation(
              origin={30,-14},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
            Placement(transformation(
              origin={-12,-48},
              extent={{-10,-10},{10,10}},
              rotation=90)));
        Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
          mechanicalPowerSensor
          annotation (Placement(transformation(extent={{44,-24},{64,-4}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
            terminalConnection="Y")
          annotation (Placement(transformation(extent={{-12,-2},{8,18}})));
        Modelica.Mechanics.Rotational.Sources.Speed speed(exact=false)
                                                          annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={80,-14})));
        Modelica.Electrical.MultiPhase.Sensors.VoltageSensor voltageSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={20,50})));
        Modelica.Electrical.MultiPhase.Blocks.QuasiRMS rms annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-24,36})));
        Controls.IEEEtype1AVR iEEEtype1AVR(
          T_R=0.01,
          T_C=0.001,
          T_B=0.001,
          K_A=200,
          T_A=0.001,
          K_E=1,
          T_E=0.001,
          K_F=0.001,
          T_F=0.1,
          Vmax=7,
          Vmin=-5,
          Vref=1.05)
                  annotation (Placement(transformation(
              extent={{-15,-10},{15,10}},
              rotation=0,
              origin={-121,24})));
        Modelica.Blocks.Math.Gain PerUnitConversion(k=1/Data.VsNominal) annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-56,36})));
        Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-42,-14})));
        Modelica.Blocks.Interfaces.RealInput w_ref(unit="rad/s") annotation (
            Placement(transformation(rotation=0, extent={{92,30},{112,50}}),
              iconTransformation(extent={{92,30},{112,50}})));
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug plugSupply
          annotation (Placement(transformation(rotation=0, extent={{-188,-20},{
                  -168,0}})));
        Modelica.Blocks.Math.Gain PerUnitConversion1(k=2)               annotation (
           Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-76,-28})));

        Modelica.Blocks.Interfaces.RealOutput dV annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-84,130})));
        Modelica.Blocks.Interfaces.RealOutput dEfd annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-178,130})));
        Modelica.Blocks.Sources.Constant Reference(k=1.03) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-166,42})));
        parameter Records.SynchronousMachine.SM100kVA Data(IeOpenCircuit=4)
          annotation (Placement(transformation(extent={{10,-60},{30,-40}})));
        Modelica.Blocks.Interfaces.RealInput PSS annotation (Placement(
              transformation(
              rotation=0,
              extent={{-10,-10},{10,10}},
              origin={-182,18}), iconTransformation(extent={{-120,92},{-100,112}})));
        Modelica.Blocks.Interfaces.RealOutput dd annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={12,132})));
      equation
        connect(rotorDisplacementAngle.plug_n,smee. plug_sn) annotation (Line(
              points={{36,-4},{36,6},{-10,6},{-10,-4}},       color={0,0,255}));
        connect(rotorDisplacementAngle.plug_p,smee. plug_sp)
          annotation (Line(points={{24,-4},{2,-4}},    color={0,0,255}));
        connect(terminalBox.plug_sn,smee. plug_sn) annotation (Line(
            points={{-8,2},{-8,-4},{-10,-4}},
            color={0,0,255}));
        connect(terminalBox.plug_sp,smee. plug_sp) annotation (Line(
            points={{4,2},{2,2},{2,-4}},
            color={0,0,255}));
        connect(smee.flange,rotorDisplacementAngle. flange) annotation (Line(
            points={{6,-14},{20,-14}}));
        connect(smee.flange,mechanicalPowerSensor. flange_a) annotation (Line(
            points={{6,-14},{44,-14}}));
        connect(speed.flange,mechanicalPowerSensor. flange_b)
          annotation (Line(points={{70,-14},{64,-14}}, color={0,0,0}));
        connect(voltageSensor.plug_p,rotorDisplacementAngle. plug_p)
          annotation (Line(points={{10,50},{10,-4},{24,-4}}, color={0,0,255}));
        connect(voltageSensor.plug_n,rotorDisplacementAngle. plug_n)
          annotation (Line(points={{30,50},{30,-4},{36,-4}}, color={0,0,255}));
        connect(rms.u,voltageSensor. v)
          annotation (Line(points={{-12,36},{20,36},{20,39}}, color={0,0,127}));
        connect(PerUnitConversion.u,rms. y)
          annotation (Line(points={{-44,36},{-35,36}}, color={0,0,127}));
        connect(signalVoltage.p,smee. pin_ep) annotation (Line(points={{-42,-4},{-30,-4},
                {-30,-8},{-14,-8}}, color={0,0,255}));
        connect(signalVoltage.n,smee. pin_en) annotation (Line(points={{-42,-24},{-30,
                -24},{-30,-20},{-14,-20}}, color={0,0,255}));
        connect(groundExcitation.p,signalVoltage. n) annotation (Line(points={{-22,-48},
                {-42,-48},{-42,-24}},           color={0,0,255}));
        connect(w_ref, speed.w_ref)
          annotation (Line(points={{102,40},{96,40},{96,-14},{92,-14}},
                                                        color={0,0,127}));
        connect(plugSupply, terminalBox.plugSupply) annotation (Line(points={{-178,
                -10},{-178,-6},{-2,-6},{-2,4}},
                                         color={0,0,255}));
        connect(PerUnitConversion1.y, signalVoltage.v) annotation (Line(points={{-65,-28},
                {-26,-28},{-26,-14},{-30,-14}},            color={0,0,127}));
        connect(Reference.y, iEEEtype1AVR.Ref) annotation (Line(points={{-155,42},
                {-152,42},{-152,32.6},{-136.8,32.6}},
                                                   color={0,0,127}));
        connect(iEEEtype1AVR.PSS, PSS) annotation (Line(points={{-136.6,17.2},{
                -136.6,18.8},{-182,18.8},{-182,18}}, color={0,0,127}));
        connect(PerUnitConversion.y, iEEEtype1AVR.Vterm) annotation (Line(
              points={{-67,36},{-142,36},{-142,24.2},{-136.6,24.2}}, color={0,0,
                127}));
        connect(iEEEtype1AVR.Efd, PerUnitConversion1.u) annotation (Line(points={{-103.7,
                23.5},{-103.7,-30.25},{-88,-30.25},{-88,-28}},         color={0,
                0,127}));
        connect(iEEEtype1AVR.Efd, dEfd) annotation (Line(points={{-103.7,23.5},
                {-103.7,72.75},{-178,72.75},{-178,130}}, color={0,0,127}));
        connect(dV, iEEEtype1AVR.Vterm) annotation (Line(points={{-84,130},{-80,
                36},{-142,36},{-142,24.2},{-136.6,24.2}}, color={0,0,127}));
        connect(rotorDisplacementAngle.rotorDisplacementAngle, dd) annotation (
            Line(points={{30,-25},{22,-25},{22,132},{12,132}}, color={0,0,127}));
        annotation (Diagram(coordinateSystem(extent={{-180,-80},{100,120}})), Icon(
              coordinateSystem(extent={{-180,-80},{100,120}}), graphics={
              Rectangle(
                extent={{-52,102},{68,-18}},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={0,128,255}),
              Rectangle(
                extent={{-52,102},{-72,-18}},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={128,128,128}),
              Rectangle(
                extent={{-52,112},{28,92}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-62,-48},{-52,-48},{-22,22},{28,22},{58,-48},{68,-48},
                    {68,-58},{-62,-58},{-62,-48}},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-162,-78},{138,-118}},
                lineColor={0,0,255},
                textString="%name"),
              Text(
                extent={{-102,158},{100,122}},
                lineColor={0,0,0},
                lineThickness=1,
                textString="%name
",              fontSize=16)}),
          experiment(
            StopTime=50,
            Interval=0.0001,
            Tolerance=1e-08,
            __Dymola_fixedstepsize=1e-07,
            __Dymola_Algorithm="Dassl"));
      end SG;

      package Controls
        model AVR_Type_DC1
          extends Interfaces.Controller;
            parameter Real T_R "Rate Filter Time Constant";
            parameter Real T_C, T_B "TGR Time Constants";
            parameter Real K_A "Regulator Gain";
            parameter Real T_A "Regulator Time Constant";
            parameter Real K_E "Exciter Gain";
            parameter Real T_E "Exciter Time Constant";
            parameter Real K_F "Rate Feedback Gain";
            parameter Real T_F "Rate Feedback Time Constant";
            parameter Real Vmax "Regulator Maximum Output";
            parameter Real Vmin "Regulator Minimum Output";
            parameter Real K_D      "Armatture reactance demagnetizing coeffcient";
            parameter Real K_C   "Commutation reactance coefficient";
            parameter Real Efdmax  "Excitation voltage maximum";
            parameter Real Efdmin    "Excitation voltage minimum";
            parameter Real K_p   "Excitation voltage minimum";
            parameter Real K_i     "Excitation voltage minimum";
            parameter Real K_G;
            parameter Real K_M;
            parameter Real T_M;
            parameter Real V_Mmax;
            parameter Real V_Mmin;
            parameter Real X_L;
            parameter Real V_Gmax;
            parameter Real th;
            parameter Real K_g;
            parameter Real V_Imax;
            parameter Real V_Imin;
          Modelica.Blocks.Continuous.FirstOrder LPF(
            k=1,
            T=T_R,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=0)                                          "Low Pass Filter"
            annotation (Placement(transformation(extent={{-224,-10},{-204,10}})));
          Modelica.Blocks.Continuous.TransferFunction LeadLag(
            b={T_C,1},
            a={T_B,1},
            initType=Modelica.Blocks.Types.Init.NoInit,
            x_start={0})
            annotation (Placement(transformation(extent={{-124,-2},{-104,18}})));
          Modelica.Blocks.Continuous.FirstOrder Regulator(
            k=K_A,
            T=T_A,
            initType=Modelica.Blocks.Types.Init.NoInit)                 "Regulator"
            annotation (Placement(transformation(extent={{-90,-2},{-70,18}})));
          Modelica.Blocks.Continuous.TransferFunction TGR(b={K_F,0}, a={T_F,1})
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-86,-62})));
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Vmax, uMin=Vmin)
            annotation (Placement(transformation(extent={{-52,-2},{-32,18}})));
          Modelica.Blocks.Math.Add3 SUM(k2=-1, k3=-1)
            annotation (Placement(transformation(extent={{-156,-2},{-136,18}})));
          Modelica.Blocks.Math.Gain gain(k=K_E) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={12,-38})));
          Modelica.Blocks.Math.Add3 add3_1(k2=-1, k3=-1)
            annotation (Placement(transformation(extent={{-16,-10},{4,10}})));
          Modelica.Blocks.Math.Gain gain1(k=1/T_E) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={22,0})));
          Modelica.Blocks.Continuous.Integrator integrator
            annotation (Placement(transformation(extent={{40,-10},{60,10}})));
          Modelica.Blocks.Sources.Constant const(k=Ref)
            annotation (Placement(transformation(extent={{-246,48},{-226,68}})));
          Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=3, uMin=-3)
            annotation (Placement(transformation(extent={{68,-10},{88,10}})));
        equation
          connect(Regulator.u,LeadLag. y)
            annotation (Line(points={{-92,8},{-103,8}},color={0,0,127}));
          connect(limiter.u,Regulator. y)
            annotation (Line(points={{-54,8},{-69,8}}, color={0,0,127}));
          connect(SUM.y,LeadLag. u)
            annotation (Line(points={{-135,8},{-126,8}}, color={0,0,127}));
          connect(LPF.y,SUM. u2)
            annotation (Line(points={{-203,0},{-166,0},{-166,8},{-158,8}},
                                                         color={0,0,127}));
          connect(TGR.y,SUM. u3) annotation (Line(points={{-97,-62},{-164,-62},{-164,0},
                  {-158,0}},  color={0,0,127}));
          connect(add3_1.u1,limiter. y)
            annotation (Line(points={{-18,8},{-31,8}},
                                                     color={0,0,127}));
          connect(gain.y,add3_1. u3) annotation (Line(points={{1,-38},{-24,-38},{-24,-8},
                  {-18,-8}},      color={0,0,127}));
          connect(gain1.u,add3_1. y)
            annotation (Line(points={{10,0},{5,0}},    color={0,0,127}));
          connect(integrator.u,gain1. y)
            annotation (Line(points={{38,0},{33,0}},   color={0,0,127}));
          connect(gain.u,integrator. y)
            annotation (Line(points={{24,-38},{61,-38},{61,0}},  color={0,0,127}));
          connect(add3_1.u2,integrator. y) annotation (Line(points={{-18,0},{-28,0},{-28,
                  -24},{61,-24},{61,0}},      color={0,0,127}));
          connect(TGR.u,integrator. y) annotation (Line(points={{-74,-62},{74,-62},{74,-38},
                  {61,-38},{61,0}},           color={0,0,127}));
          connect(LPF.u, Measurement) annotation (Line(points={{-226,0},{-280,0}},
                               color={0,0,127}));
          connect(const.y, SUM.u1) annotation (Line(points={{-225,58},{-164,58},{-164,16},
                  {-158,16}}, color={0,0,127}));
          connect(limiter1.u, integrator.y)
            annotation (Line(points={{66,0},{61,0}}, color={0,0,127}));
          connect(limiter1.y, Actuation)
            annotation (Line(points={{89,0},{110,0}}, color={0,0,127}));
          annotation (Diagram(coordinateSystem(extent={{-280,-100},{100,100}})), Icon(
                coordinateSystem(extent={{-280,-100},{100,100}}), graphics={Text(
                  extent={{-196,16},{8,-40}},
                  lineColor={28,108,200},
                  textString="IEEE Type I
")}));
        end AVR_Type_DC1;

        model IEEEtype1AVR
          parameter Real T_R "Rate Filter Time Constant";
          parameter Real T_C, T_B "TGR Time Constants";
          parameter Real K_A "Regulator Gain";
          parameter Real T_A "Regulator Time Constant";
          parameter Real K_E "Exciter Gain";
          parameter Real T_E "Exciter Time Constant";
          parameter Real K_F "Rate Feedback Gain";
          parameter Real T_F "Rate Feedback Time Constant";
          parameter Real Vmax "Regulator Maximum Output";
          parameter Real Vmin "Regulator Minimum Output";
          parameter Real Vref "Terminal Reference Voltage (pu)";
          Modelica.Blocks.Interfaces.RealInput Vterm
            annotation (Placement(transformation(extent={{-226,-18},{-186,22}})));
          Modelica.Blocks.Continuous.FirstOrder LPF(k=1, T=T_R,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=0)                                          "Low Pass Filter"
            annotation (Placement(transformation(extent={{-184,-2},{-164,18}})));
          Modelica.Blocks.Continuous.TransferFunction LeadLag(b={T_C,1}, a={T_B,1},
            initType=Modelica.Blocks.Types.Init.NoInit,
            x_start={0})
            annotation (Placement(transformation(extent={{-102,-8},{-82,12}})));
          Modelica.Blocks.Continuous.FirstOrder Regulator(k=K_A, T=T_A,
            initType=Modelica.Blocks.Types.Init.NoInit)                 "Regulator"
            annotation (Placement(transformation(extent={{-68,-8},{-48,12}})));
          Modelica.Blocks.Continuous.TransferFunction TGR(b={K_F,0}, a={T_F,1})
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-64,-68})));
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Vmax, uMin=Vmin)
            annotation (Placement(transformation(extent={{-30,-8},{-10,12}})));
          Modelica.Blocks.Math.Add3 SUM(k2=-1, k3=-1)
            annotation (Placement(transformation(extent={{-128,-8},{-108,12}})));
          Modelica.Blocks.Interfaces.RealOutput Efd
            annotation (Placement(transformation(extent={{104,-24},{142,14}})));
          Modelica.Blocks.Math.Gain gain(k=K_E) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={34,-44})));
          Modelica.Blocks.Math.Add3 add3_1(k2=-1, k3=-1)
            annotation (Placement(transformation(extent={{16,-16},{36,4}})));
          Modelica.Blocks.Math.Gain gain1(k=1/T_E) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={56,-6})));
          Modelica.Blocks.Continuous.Integrator integrator(y_start=1)
            annotation (Placement(transformation(extent={{74,-16},{94,4}})));
          Modelica.Blocks.Interfaces.RealInput Ref annotation (Placement(
                transformation(extent={{-228,66},{-188,106}})));
          Modelica.Blocks.Interfaces.RealInput PSS annotation (Placement(
                transformation(extent={{-226,-88},{-186,-48}})));
          Modelica.Blocks.Math.Add add annotation (Placement(transformation(
                  extent={{-154,-8},{-134,12}})));
        equation
          connect(LPF.u, Vterm)
            annotation (Line(points={{-186,8},{-188,8},{-188,2},{-206,2}},
                                                         color={0,0,127}));
          connect(Regulator.u, LeadLag.y)
            annotation (Line(points={{-70,2},{-81,2}}, color={0,0,127}));
          connect(limiter.u, Regulator.y)
            annotation (Line(points={{-32,2},{-47,2}}, color={0,0,127}));
          connect(SUM.y, LeadLag.u)
            annotation (Line(points={{-107,2},{-104,2}}, color={0,0,127}));
          connect(TGR.y, SUM.u3) annotation (Line(points={{-75,-68},{-132,-68},
                  {-132,-6},{-130,-6}},
                              color={0,0,127}));
          connect(add3_1.u1, limiter.y)
            annotation (Line(points={{14,2},{-9,2}}, color={0,0,127}));
          connect(gain.y, add3_1.u3) annotation (Line(points={{23,-44},{-2,-44},{-2,
                  -14},{14,-14}}, color={0,0,127}));
          connect(gain1.u, add3_1.y)
            annotation (Line(points={{44,-6},{37,-6}}, color={0,0,127}));
          connect(integrator.u, gain1.y)
            annotation (Line(points={{72,-6},{67,-6}}, color={0,0,127}));
          connect(gain.u, integrator.y)
            annotation (Line(points={{46,-44},{95,-44},{95,-6}}, color={0,0,127}));
          connect(add3_1.u2, integrator.y) annotation (Line(points={{14,-6},{10,-6},
                  {10,-28},{95,-28},{95,-6}}, color={0,0,127}));
          connect(TGR.u, integrator.y) annotation (Line(points={{-52,-68},{96,-68},
                  {96,-44},{95,-44},{95,-6}}, color={0,0,127}));
          connect(integrator.y,Efd)  annotation (Line(points={{95,-6},{98,-6},{
                  98,-5},{123,-5}},
                            color={0,0,127}));
          connect(SUM.u1, Ref) annotation (Line(points={{-130,10},{-130,48},{
                  -208,48},{-208,86}}, color={0,0,127}));
          connect(add.y, SUM.u2)
            annotation (Line(points={{-133,2},{-130,2}}, color={0,0,127}));
          connect(LPF.y, add.u1)
            annotation (Line(points={{-163,8},{-156,8}}, color={0,0,127}));
          connect(add.u2, PSS) annotation (Line(points={{-156,-4},{-164,-4},{
                  -164,-68},{-206,-68}}, color={0,0,127}));
            annotation (Placement(transformation(extent={{66,-20},{106,20}})),
                      Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-100},
                    {100,100}})), Diagram(coordinateSystem(preserveAspectRatio=false,
                  extent={{-200,-100},{100,100}})));
        end IEEEtype1AVR;

        model AVR_AC
          extends Interfaces.Controller;
            parameter Real T_R "Rate Filter Time Constant";
            parameter Real T_C, T_B "TGR Time Constants";
            parameter Real K_A "Regulator Gain";
            parameter Real T_A "Regulator Time Constant";
            parameter Real K_E "Exciter Gain";
            parameter Real T_E "Exciter Time Constant";
            parameter Real K_F "Rate Feedback Gain";
            parameter Real T_F "Rate Feedback Time Constant";
            parameter Real K_D  "Ifd to VFE Gain";
            parameter Real K_C  "Ifd to IN Gain";
            parameter Real Vmax "Regulator Maximum Output";
            parameter Real Vmin "Regulator Minimum Output";

            parameter Real Efdmax
                                 "Excitation voltage maximum";
            parameter Real Efdmin   "Excitation voltage minimum";
            parameter Real K_p     "Excitation voltage minimum";
            parameter Real K_i    "Excitation voltage minimum";
            parameter Real K_G;
            parameter Real K_M;
            parameter Real T_M;
            parameter Real V_Mmax;
            parameter Real V_Mmin;
            parameter Real X_L;
            parameter Real V_Gmax;
            parameter Real th;
            parameter Real K_g;
            parameter Real V_Imax;
            parameter Real V_Imin;

          Modelica.Blocks.Continuous.FirstOrder LPF(
            k=1,
            T=T_R,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=0)                                          "Low Pass Filter"
            annotation (Placement(transformation(extent={{-240,-50},{-220,-30}})));
          Modelica.Blocks.Continuous.TransferFunction LeadLag(
            b={T_C,1},
            a={T_B,1},
            initType=Modelica.Blocks.Types.Init.NoInit,
            x_start={0})
            annotation (Placement(transformation(extent={{-162,40},{-142,60}})));
          Modelica.Blocks.Continuous.FirstOrder Regulator(
            k=K_A,
            T=T_A,
            initType=Modelica.Blocks.Types.Init.NoInit)                 "Regulator"
            annotation (Placement(transformation(extent={{-134,40},{-114,60}})));
          Modelica.Blocks.Continuous.TransferFunction TGR(b={K_F,0}, a={T_F,1})
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-180,-60})));
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Vmax, uMin=Vmin)
            annotation (Placement(transformation(extent={{-98,40},{-78,60}})));
          Modelica.Blocks.Math.Add3 SUM(k2=-1, k3=-1)
            annotation (Placement(transformation(extent={{-200,40},{-180,60}})));
          Modelica.Blocks.Math.Gain gain(k=K_E) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-2,-30})));
          Modelica.Blocks.Math.Gain gain1(k=1/T_E) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={4,44})));
          Modelica.Blocks.Continuous.Integrator integrator
            annotation (Placement(transformation(extent={{30,34},{50,54}})));
          Modelica.Blocks.Math.Add add(k2=-1)
            annotation (Placement(transformation(extent={{-42,34},{-22,54}})));
          Modelica.Blocks.Math.Add3 add3_1 annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-48,-26})));
          Modelica.Blocks.Math.Gain gain2(k=K_D)
                                                annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={-14,-72})));
          Modelica.Blocks.Math.Product product
            annotation (Placement(transformation(extent={{76,44},{96,64}})));
          Modelica.Blocks.Math.Division division annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={76,-26})));
          Modelica.Blocks.Math.Gain gain3(k=K_C)
                                                annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={70,-58})));
          F_EX f_EX annotation (Placement(transformation(
                extent={{-10.5,-6.5},{10.5,6.5}},
                rotation=90,
                origin={76.5,-0.5})));
          Modelica.Blocks.Sources.Constant const(k=Ref)
            annotation (Placement(transformation(extent={{-276,50},{-256,70}})));
          Modelica.Blocks.Math.Max max annotation (Placement(transformation(
                  extent={{-66,-82},{-46,-62}})));
          Modelica.Blocks.Sources.Constant const1(k=0.001)
            annotation (Placement(transformation(extent={{-248,-86},{-228,-66}})));
          Modelica.Blocks.Math.Max max1 annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=90,
                origin={108,-46})));
          Modelica.Blocks.Sources.Constant const2(k=0.001)
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=90,
                origin={118,-86})));
          Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=5, uMin=-5)
            annotation (Placement(transformation(extent={{102,44},{122,64}})));
          Modelica.Blocks.Continuous.FirstOrder LPF1(
            k=1,
            T=0.01,
            initType=Modelica.Blocks.Types.Init.SteadyState,
            y_start=0)                                          "Low Pass Filter"
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=90,
                origin={76,28})));
        equation
          connect(Regulator.u,LeadLag. y)
            annotation (Line(points={{-136,50},{-141,50}},
                                                       color={0,0,127}));
          connect(limiter.u,Regulator. y)
            annotation (Line(points={{-100,50},{-113,50}},
                                                       color={0,0,127}));
          connect(SUM.y,LeadLag. u)
            annotation (Line(points={{-179,50},{-164,50}},
                                                         color={0,0,127}));
          connect(LPF.y,SUM. u2)
            annotation (Line(points={{-219,-40},{-214,-40},{-214,50},{-202,50}},
                                                         color={0,0,127}));
          connect(integrator.u,gain1. y)
            annotation (Line(points={{28,44},{15,44}}, color={0,0,127}));
          connect(gain.u,integrator. y)
            annotation (Line(points={{10,-30},{51,-30},{51,44}}, color={0,0,127}));
          connect(TGR.u,integrator. y) annotation (Line(points={{-168,-60},{50,
                  -60},{50,-36},{51,-36},{51,44}},
                                              color={0,0,127}));
          connect(LPF.u, Measurement) annotation (Line(points={{-242,-40},{-262,
                  -40},{-262,0},{-280,0}},
                               color={0,0,127}));
          connect(TGR.y, SUM.u3) annotation (Line(points={{-191,-60},{-206,-60},{-206,42},
                  {-202,42}}, color={0,0,127}));
          connect(add.u1, limiter.y)
            annotation (Line(points={{-44,50},{-77,50}}, color={0,0,127}));
          connect(add.y, gain1.u)
            annotation (Line(points={{-21,44},{-8,44}}, color={0,0,127}));
          connect(add3_1.u2, gain.y) annotation (Line(points={{-36,-26},{-28,
                  -26},{-28,-30},{-13,-30}}, color={0,0,127}));
          connect(add3_1.u3, integrator.y) annotation (Line(points={{-36,-18},{
                  -28,-18},{-28,-16},{51,-16},{51,44}}, color={0,0,127}));
          connect(gain2.y, add3_1.u1) annotation (Line(points={{-3,-72},{-26,
                  -72},{-26,-34},{-36,-34}},
                                        color={0,0,127}));
          connect(add3_1.y, add.u2) annotation (Line(points={{-59,-26},{-66,-26},
                  {-66,38},{-44,38}}, color={0,0,127}));
          connect(product.u1, integrator.y) annotation (Line(points={{74,60},{
                  54,60},{54,44},{51,44}}, color={0,0,127}));
          connect(gain3.y, division.u1)
            annotation (Line(points={{70,-47},{70,-38}}, color={0,0,127}));
          connect(const.y, SUM.u1) annotation (Line(points={{-255,60},{-228,60},{-228,58},
                  {-202,58}}, color={0,0,127}));
          connect(const1.y, max.u1) annotation (Line(points={{-227,-76},{-212.5,
                  -76},{-212.5,-66},{-68,-66}},  color={0,0,127}));
          connect(max.y, gain2.u) annotation (Line(points={{-45,-72},{-26,-72}},
                                        color={0,0,127}));
          connect(gain3.u, gain2.u) annotation (Line(points={{70,-70},{42,-70},
                  {42,-72},{-26,-72}}, color={0,0,127}));
          connect(max1.y, division.u2) annotation (Line(points={{108,-35},{92,
                  -35},{92,-38},{82,-38}}, color={0,0,127}));
          connect(const2.y, max1.u2) annotation (Line(points={{118,-75},{118,
                  -58},{114,-58}},           color={0,0,127}));
          connect(max1.u1, integrator.y) annotation (Line(points={{102,-58},{54,
                  -58},{54,44},{51,44}}, color={0,0,127}));
          connect(product.y, limiter1.u)
            annotation (Line(points={{97,54},{100,54}}, color={0,0,127}));
          connect(limiter1.y, Actuation) annotation (Line(points={{123,54},{123,
                  28},{110,28},{110,0}}, color={0,0,127}));
          connect(division.y, f_EX.I_N) annotation (Line(points={{76,-15},{76,
                  -11},{76.11,-11}}, color={0,0,127}));
          connect(LPF1.u, f_EX.F_EX) annotation (Line(points={{76,16},{76,14},{
                  76,11.26},{76.24,11.26}}, color={0,0,127}));
          connect(LPF1.y, product.u2) annotation (Line(points={{76,39},{76,48},
                  {74,48}}, color={0,0,127}));
          connect(max.u2, Aux_3) annotation (Line(points={{-68,-78},{-76,-78},{
                  -76,-100},{0,-100}}, color={0,0,127}));
          annotation (Diagram(coordinateSystem(extent={{-280,-100},{140,100}})), Icon(
                coordinateSystem(extent={{-280,-100},{140,100}}), graphics={Text(
                  extent={{-182,10},{22,-46}},
                  lineColor={28,108,200},
                  textString="IEEE Type II
")}));
        end AVR_AC;

        model AVR_Type_ST3
          extends Interfaces.Controller;
          parameter Real T_R   "Rate Filter Time Constant";
          parameter Real T_C      "TGR Time Constant";
          parameter Real T_B     "TGR Time Constant";
          parameter Real K_A     "Regulator Gain";
          parameter Real T_A     "Regulator Time Constant";
          parameter Real K_E       "Exciter Gain";
          parameter Real T_E    "Exciter Time Constant";
          parameter Real K_F    "Rate Feedback Gain";
          parameter Real T_F     "Rate Feedback Time Constant";
          parameter Real K_D    "Armatture reactance demagnetizing coeffcient";
          parameter Real K_C    "Commutation reactance coefficient";
          parameter Real Vmax    "Regulator Maximum Output";
          parameter Real Vmin       "Regulator Minimum Output";
          parameter Real Efdmax  "Excitation voltage maximum";
          parameter Real Efdmin    "Excitation voltage minimum";
          parameter Real K_p     "Excitation voltage minimum";
          parameter Real K_i     "Excitation voltage minimum";
          parameter Real K_M;
          parameter Real T_M;
          parameter Real V_Mmax;
          parameter Real V_Mmin;
          parameter Real X_L;
          parameter Real V_Gmax;
          parameter Real th;
          parameter Real K_G;
          parameter Real V_Imax;
          parameter Real V_Imin;

          Modelica.Blocks.Continuous.TransferFunction LeadLag(
            b={T_C,1},
            a={T_B,1},
            initType=Modelica.Blocks.Types.Init.NoInit,
            x_start={0})
            annotation (Placement(transformation(extent={{-152,-2},{-132,18}})));
          Modelica.Blocks.Continuous.FirstOrder Regulator(
            k=K_A,
            T=T_A,
            initType=Modelica.Blocks.Types.Init.NoInit)                 "Regulator"
            annotation (Placement(transformation(extent={{-122,-2},{-102,18}})));
          Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Vmax, uMin=Vmin)
            annotation (Placement(transformation(extent={{-94,-2},{-74,18}})));
          Modelica.Blocks.Continuous.TransferFunction Exciter(
            b={1},
            a={T_E,K_E},
            initType=Modelica.Blocks.Types.Init.NoInit,
            x_start={0})
            annotation (Placement(transformation(extent={{-28,4},{-8,24}})));
          Modelica.Blocks.Math.Division division annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={12,-64})));
          Modelica.Blocks.Math.Gain gain3(k=K_C)
                                                annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={-56,-70})));
          Modelica.Blocks.Math.Product product
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=0,
                origin={62,0})));
          Modelica.Blocks.Math.Gain KG(k=K_G) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={16,58})));
          Modelica.Blocks.Math.Add add(k1=-1)
            annotation (Placement(transformation(extent={{-60,4},{-40,24}})));
          F_EX f_EX annotation (Placement(transformation(extent={{32,-84},{48,-74}})));
          Modelica.Blocks.Math.Product product1
            annotation (Placement(transformation(extent={{-10,-10},{10,10}},
                rotation=90,
                origin={10,-28})));
          Modelica.Blocks.Nonlinear.Limiter Efd_max(uMax=Efdmax, uMin=-9999)
            annotation (Placement(transformation(extent={{78,-10},{98,10}})));
          Modelica.Blocks.Nonlinear.Limiter Vb(uMax=9999,  uMin=-9999)
            annotation (Placement(transformation(extent={{24,-16},{44,4}})));
          Modelica.Blocks.Nonlinear.Limiter Vg(uMax=V_Gmax,uMin=-9999) annotation (
              Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={-16,58})));
          Modelica.Blocks.Nonlinear.Limiter Vb1(uMax=V_Mmax, uMin=V_Mmin)
            annotation (Placement(transformation(extent={{0,4},{20,24}})));
          Modelica.Blocks.Math.Add add1(k1=+1, k2=-1)
            annotation (Placement(transformation(extent={{-242,-2},{-222,18}})));
          PotentialCircuit potentialCircuit(
            Kp=K_p,
            th=th,
            Ki=K_i,
            Xl=X_L) annotation (Placement(transformation(extent={{-88,-46},{-68,-26}})));
          Modelica.Blocks.Nonlinear.Limiter Vb2(uMax=V_Imax, uMin=V_Imin)
            annotation (Placement(transformation(extent={{-202,-2},{-182,18}})));
          Modelica.Blocks.Sources.Constant const(k=Ref) annotation (Placement(
                transformation(extent={{-276,50},{-256,70}})));
        equation
          connect(Regulator.u,LeadLag. y)
            annotation (Line(points={{-124,8},{-131,8}},
                                                       color={0,0,127}));
          connect(limiter.u,Regulator. y)
            annotation (Line(points={{-96,8},{-101,8}},color={0,0,127}));
          connect(gain3.y,division. u1)
            annotation (Line(points={{-45,-70},{-10,-70},{-10,-58},{0,-58}},
                                                         color={0,0,127}));
          connect(add.y, Exciter.u)
            annotation (Line(points={{-39,14},{-30,14}},
                                                       color={0,0,127}));
          connect(add.u2, limiter.y)
            annotation (Line(points={{-62,8},{-73,8}}, color={0,0,127}));
          connect(f_EX.I_N, division.y) annotation (Line(points={{32,-78.7},{32,-64},{23,
                  -64}},     color={0,0,127}));
          connect(product1.u2, f_EX.F_EX) annotation (Line(points={{16,-40},{56,-40},{56,
                  -78.8},{48.96,-78.8}},         color={0,0,127}));
          connect(product.y, Efd_max.u)
            annotation (Line(points={{73,0},{76,0}}, color={0,0,127}));
          connect(Actuation, Efd_max.y)
            annotation (Line(points={{110,0},{99,0}},  color={0,0,127}));
          connect(Vb.y, product.u2)
            annotation (Line(points={{45,-6},{50,-6}}, color={0,0,127}));
          connect(product1.y, Vb.u)
            annotation (Line(points={{10,-17},{10,-6},{22,-6}}, color={0,0,127}));
          connect(KG.u, Efd_max.u)
            annotation (Line(points={{28,58},{76,58},{76,0}},        color={0,0,127}));
          connect(Vg.u, KG.y)
            annotation (Line(points={{-4,58},{5,58}}, color={0,0,127}));
          connect(Vg.y, add.u1) annotation (Line(points={{-27,58},{-62,58},{-62,20}},
                        color={0,0,127}));
          connect(Vb1.u, Exciter.y)
            annotation (Line(points={{-2,14},{-7,14}}, color={0,0,127}));
          connect(Vb1.y, product.u1)
            annotation (Line(points={{21,14},{46,14},{46,6},{50,6}}, color={0,0,127}));
          connect(potentialCircuit.V, Measurement) annotation (Line(points={{-88,-29},
                  {-204,-29},{-204,-30},{-256,-30},{-256,0},{-280,0}},
                                                                     color={0,0,127}));
          connect(division.u2, potentialCircuit.Ve) annotation (Line(points={{0,-70},{-14,
                  -70},{-14,-36},{-67,-36}}, color={0,0,127}));
          connect(product1.u1, potentialCircuit.Ve) annotation (Line(points={{4,-40},{-14,
                  -40},{-14,-36},{-67,-36}}, color={0,0,127}));
          connect(add1.u2, Measurement) annotation (Line(points={{-244,2},{-250,
                  2},{-250,-30},{-256,-30},{-256,0},{-280,0}},
                                                          color={0,0,127}));
          connect(Vb2.u, add1.y)
            annotation (Line(points={{-204,8},{-221,8}}, color={0,0,127}));
          connect(Vb2.y, LeadLag.u)
            annotation (Line(points={{-181,8},{-154,8}}, color={0,0,127}));
          connect(add1.u1, const.y) annotation (Line(points={{-244,14},{-244,38},
                  {-255,38},{-255,60}}, color={0,0,127}));
          connect(Aux_3, gain3.u) annotation (Line(points={{0,-100},{-36,-100},
                  {-36,-70},{-68,-70}}, color={0,0,127}));
          connect(Aux_1, potentialCircuit.Im) annotation (Line(points={{-190,
                  -100},{-140,-100},{-140,-36},{-88,-36}}, color={0,0,127}));
          connect(potentialCircuit.Ith, Aux_2) annotation (Line(points={{-88,
                  -42.8},{-88,-64.4},{-98,-64.4},{-98,-100}}, color={0,0,127}));
          annotation (Diagram(coordinateSystem(extent={{-280,-100},{100,100}})), Icon(
                coordinateSystem(extent={{-280,-100},{100,100}}), graphics={
                  Text(
                  extent={{-196,16},{8,-40}},
                  lineColor={28,108,200},
                  textString="IEEE Type III
")}));
        end AVR_Type_ST3;

        model F_EX

          Modelica.Blocks.Interfaces.RealInput I_N annotation (Placement(
                transformation(extent={{-120,-14},{-80,26}})));
          Modelica.Blocks.Interfaces.RealOutput F_EX
            annotation (Placement(transformation(extent={{102,-6},{122,14}})));
        equation

          if I_N >= 0  and I_N<0.43 then
            F_EX = 1-0.5773*I_N;
          elseif I_N>=0.43 and I_N<0.75 then
            F_EX = sqrt(max(0.75-I_N^2,0));
          elseif I_N>=0.75 and I_N<1 then
            F_EX = 1.732*(1-I_N);
          else
            F_EX = 0;
          end if;

        end F_EX;

        model PotentialCircuit
          parameter Real Kp;
          parameter Real th;
          parameter Real Ki;
          parameter Real Xl;
          Real a;
          Real b;

          Modelica.Blocks.Interfaces.RealInput V annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-100,70})));
          Modelica.Blocks.Interfaces.RealInput Ith annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-100,-68})));
          Modelica.Blocks.Interfaces.RealInput Im annotation (Placement(transformation(
                extent={{-20,-20},{20,20}},
                rotation=0,
                origin={-100,0})));
          Modelica.Blocks.Interfaces.RealOutput Ve annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=0,
                origin={110,0})));
        equation
          a = Kp*V*cos(th)-Ki*Im*sin(Ith)-Kp*Xl*Im*sin(th+Ith);
          b = Kp*V*sin(th) + Ki*Im*cos(th) + Kp*Xl*Im*cos(th+Ith);
          Ve = max(sqrt(a^2+b^2),0.0001);
          annotation ();
        end PotentialCircuit;

        model CurCalc
          parameter Real machBase;
          parameter Real Vrated;
          Real I_b;
          Modelica.Blocks.Interfaces.RealInput Q annotation (Placement(
                transformation(rotation=0, extent={{-110,-10},{-90,10}}),
                iconTransformation(extent={{-110,-10},{-90,10}})));
          Modelica.Blocks.Interfaces.RealInput P annotation (Placement(
                transformation(rotation=0, extent={{-110,68},{-90,88}}),
                iconTransformation(extent={{-110,68},{-90,88}})));
          Modelica.Blocks.Interfaces.RealInput V annotation (Placement(
                transformation(rotation=0, extent={{-110,-90},{-90,-70}}),
                iconTransformation(extent={{-110,-90},{-90,-70}})));
          Modelica.Blocks.Interfaces.RealOutput Im
            annotation (Placement(transformation(extent={{100,6},{120,26}})));
          Modelica.Blocks.Interfaces.RealOutput Ia
            annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
        algorithm
          I_b := machBase/(sqrt(3)*Vrated);
          Im := sqrt(P^2+Q^2)/(max(V,0.001)*I_b);
          Ia := Modelica.Math.atan(max(-Q/(max(V,0.001)*I_b),0.001)/max(P/(max(V,0.001)*I_b),0.001));
          annotation (experiment(
              StopTime=20,
              Interval=0.0001,
              __Dymola_fixedstepsize=0.001,
              __Dymola_Algorithm="Cerk45"));
        end CurCalc;

        model K_Sch

        parameter Real k1;
        parameter Real k2;

        parameter Real t;
          Modelica.Blocks.Interfaces.RealOutput y
            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
          Modelica.Blocks.Interfaces.RealInput u
            annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
        equation
          if time< t then
            y = k1*u;
          else
            y = k2*u;
          end if;
          annotation ();
        end K_Sch;
      end Controls;

      model SynGenwAVR
        extends Interfaces.Generation;
        replaceable Controls.AVR_Type_DC1
                                    AVR(
          Ref=1.02,
          T_R=Data_AVR.T_R,
          T_C=Data_AVR.T_C,
          T_B=Data_AVR.T_B,
          K_A=Data_AVR.K_A,
          T_A=Data_AVR.T_A,
          K_E=Data_AVR.K_E,
          T_E=Data_AVR.T_E,
          K_F=Data_AVR.K_F,
          T_F=Data_AVR.T_F,
          K_D=Data_AVR.K_D,
          K_C=Data_AVR.K_D,
          Vmax=Data_AVR.Vmax,
          Vmin=Data_AVR.Vmin,
          Efdmax=Data_AVR.Efdmax,
          Efdmin=Data_AVR.Efdmin,
          K_p=Data_AVR.K_p,
          K_i=Data_AVR.K_i,
          K_G=Data_AVR.K_G,
          K_M=Data_AVR.K_M,
          T_M=Data_AVR.T_M,
          V_Mmax=Data_AVR.V_Mmax,
          V_Mmin=Data_AVR.V_Mmin,
          X_L=Data_AVR.X_L,
          V_Gmax=Data_AVR.V_Gmax,
          th=Data_AVR.th,
          K_g=Data_AVR.K_G,
          V_Imax=Data_AVR.V_Imax,
          V_Imin=Data_AVR.V_Imin) constrainedby Interfaces.Controller
          annotation (Placement(transformation(extent={{-162,-26},{-124,-6}})));
        replaceable Records.Controllers.AVR_AC1A  Data_AVR constrainedby
          Records.Base.AVR
          annotation (Placement(transformation(extent={{-70,-92},{-50,-72}})));

        parameter Modelica.SIunits.Inertia J=1.5 "Rotor's moment of inertia";

        replaceable parameter Records.SynchronousMachine.SM100kVA SG_Data
          constrainedby Records.Base.Synch
          annotation (Placement(transformation(extent={{-38,-92},{-18,-72}})));

        Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
          smee(
          fsNominal=SG_Data.fsNominal,
          Rs=SG_Data.Rs,
          TsRef=SG_Data.TsRef,
          Lssigma=SG_Data.Lssigma,
          phiMechanical(fixed=false),
          wMechanical(fixed=false),
          Lmd=SG_Data.Lmd,
          Lmq=SG_Data.Lmq,
          Lrsigmad=SG_Data.Lrsigmad,
          Lrsigmaq=SG_Data.Lrsigmaq,
          Rrd=SG_Data.Rrd,
          Rrq=SG_Data.Rrq,
          TrRef=SG_Data.TrRef,
          VsNominal=SG_Data.VsNominal,
          IeOpenCircuit=SG_Data.IeOpenCircuit,
          Re=SG_Data.Re,
          TeRef=SG_Data.TeRef,
          sigmae=SG_Data.sigmae,
          p=SG_Data.Poles,
          Jr=0.02,
          Js=0.29,
          useDamperCage=useDamperCage,
          statorCoreParameters(VRef=115),
          strayLoadParameters(IRef=100),
          brushParameters(ILinear=0.01),
          TsOperational=293.15,
          alpha20s=SG_Data.alpha20s,
          TrOperational=293.15,
          alpha20r=SG_Data.alpha20r,
          alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TeOperational=293.15)
          annotation (Placement(transformation(extent={{-62,-20},{-42,0}})));

        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle
          rotorDisplacementAngle(p=SG_Data.Poles)
                                      annotation (Placement(transformation(
              origin={-18,-10},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Machines.Sensors.MechanicalPowerSensor
          mechanicalPowerSensor
          annotation (Placement(transformation(extent={{-4,-20},{16,0}})));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
            terminalConnection="Y")
          annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
        Modelica.Mechanics.Rotational.Sources.Speed speed(exact=false)
                                                          annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={32,-10})));
        Modelica.Electrical.MultiPhase.Sensors.VoltageSensor voltageSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-28,30})));
        Modelica.Electrical.MultiPhase.Blocks.QuasiRMS rms annotation (Placement(
              transformation(
              extent={{-5,-5},{5,5}},
              rotation=180,
              origin={-93,17})));
        Modelica.Blocks.Math.Gain PerUnitConversion(k=1/SG_Data.VsNominal)
                                                                        annotation (
           Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=180,
              origin={-160,18})));
        Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-100,-14})));
        Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
            Placement(transformation(
              origin={-100,-58},
              extent={{-10,-10},{10,10}},
              rotation=0)));
        Modelica.Blocks.Math.Gain PerUnitConversion1(k=4)               annotation (
           Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=0,
              origin={-116,-14})));
        parameter Boolean useDamperCage=true "Enable / disable damper cage";
        Modelica.Electrical.Machines.Sensors.ElectricalPowerSensor powerSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-192,2})));
        Controls.CurCalc curCalc(machBase=SG_Data.SNominal, Vrated=SG_Data.VsNominal)
          annotation (Placement(transformation(extent={{-172,-72},{-152,-52}})));
        Modelica.Blocks.Math.Gain PerUnitConversion2(k=1/SG_Data.IeOpenCircuit)
                                                                        annotation (
           Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=180,
              origin={-118,-34})));
        Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-62,-34})));
      equation
        connect(rotorDisplacementAngle.plug_n,smee. plug_sn) annotation (Line(
              points={{-12,0},{-12,10},{-58,10},{-58,0}},     color={0,0,255}));
        connect(rotorDisplacementAngle.plug_p,smee. plug_sp)
          annotation (Line(points={{-24,0},{-46,0}},   color={0,0,255}));
        connect(terminalBox.plug_sn,smee. plug_sn) annotation (Line(
            points={{-56,6},{-56,0},{-58,0}},
            color={0,0,255}));
        connect(terminalBox.plug_sp,smee. plug_sp) annotation (Line(
            points={{-44,6},{-46,6},{-46,0}},
            color={0,0,255}));
        connect(smee.flange,rotorDisplacementAngle. flange) annotation (Line(
            points={{-42,-10},{-28,-10}}));
        connect(smee.flange,mechanicalPowerSensor. flange_a) annotation (Line(
            points={{-42,-10},{-4,-10}}));
        connect(speed.flange,mechanicalPowerSensor. flange_b)
          annotation (Line(points={{22,-10},{16,-10}}, color={0,0,0}));
        connect(voltageSensor.plug_p,rotorDisplacementAngle. plug_p)
          annotation (Line(points={{-38,30},{-38,0},{-24,0}},color={0,0,255}));
        connect(voltageSensor.plug_n,rotorDisplacementAngle. plug_n)
          annotation (Line(points={{-18,30},{-18,0},{-12,0}},color={0,0,255}));
        connect(rms.u,voltageSensor. v)
          annotation (Line(points={{-87,17},{-28,17},{-28,19}},
                                                              color={0,0,127}));
        connect(speed.w_ref, w_ref) annotation (Line(points={{44,-10},{72,-10},
                {72,0},{100,0}}, color={0,0,127}));
        connect(PerUnitConversion.u, rms.y)
          annotation (Line(points={{-155.2,18},{-104,18},{-104,17},{-98.5,17}},
                                                        color={0,0,127}));
        connect(PerUnitConversion.y, AVR.Measurement) annotation (Line(points={{-164.4,
                18},{-162,18},{-162,-16}},       color={0,0,127}));
        connect(groundExcitation.p,signalVoltage. n) annotation (Line(points={{-100,
                -48},{-100,-24}},               color={0,0,255}));
        connect(PerUnitConversion1.y, signalVoltage.v)
          annotation (Line(points={{-111.6,-14},{-88,-14}},
                                                          color={0,0,127}));
        connect(PerUnitConversion1.u, AVR.Actuation)
          annotation (Line(points={{-120.8,-14},{-122,-14},{-122,-16},{-123,-16}},
                                                           color={0,0,127}));
        connect(powerSensor.plug_ni, AC_out)
          annotation (Line(points={{-202,2},{-222,2}}, color={0,0,255}));
        connect(powerSensor.plug_p, terminalBox.plugSupply) annotation (Line(
              points={{-182,2},{-116,2},{-116,8},{-50,8}}, color={0,0,255}));
        connect(powerSensor.plug_nv, smee.plug_sn) annotation (Line(points={{
                -192,12},{-104,12},{-104,10},{-58,10},{-58,0}}, color={0,0,255}));
        connect(curCalc.Q, powerSensor.Q) annotation (Line(points={{-172,-62},{
                -190,-62},{-190,-9},{-197,-9}}, color={0,0,127}));
        connect(curCalc.P, powerSensor.P) annotation (Line(points={{-172,-54.2},
                {-190,-54.2},{-190,-9},{-187,-9}}, color={0,0,127}));
        connect(curCalc.V, AVR.Measurement) annotation (Line(points={{-172,-70},
                {-176,-70},{-176,6},{-162,6},{-162,-16}}, color={0,0,127}));
        connect(curCalc.Im, AVR.Aux_2) annotation (Line(points={{-151,-60.4},{
                -151,-59.2},{-143.8,-59.2},{-143.8,-26}},     color={0,0,127}));
        connect(curCalc.Ia, AVR.Aux_3) annotation (Line(points={{-151,-64},{
                -134,-64},{-134,-26}},         color={0,0,127}));
        connect(PerUnitConversion2.y, AVR.Aux_1) annotation (Line(points={{-122.4,
                -34},{-156,-34},{-156,-26},{-153,-26}},            color={0,0,
                127}));
        connect(smee.pin_ep, signalVoltage.p)
          annotation (Line(points={{-62,-4},{-100,-4}}, color={0,0,255}));
        connect(currentSensor.p, smee.pin_en)
          annotation (Line(points={{-62,-24},{-62,-16}}, color={0,0,255}));
        connect(currentSensor.n, signalVoltage.n) annotation (Line(points={{-62,
                -44},{-100,-44},{-100,-24}}, color={0,0,255}));
        connect(currentSensor.i, PerUnitConversion2.u)
          annotation (Line(points={{-73,-34},{-113.2,-34}}, color={0,0,127}));
       annotation (Placement(visible=false,
            transformation(extent={{-70,8},{-70,8}}),
            iconTransformation(extent={{-70,8},{-70,8}})),
                    Icon(graphics={
              Rectangle(
                extent={{-106,68},{14,-52}},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={0,128,255}),
              Rectangle(
                extent={{-106,68},{-126,-52}},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={128,128,128}),
              Rectangle(
                extent={{14,12},{82,-8}},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={95,95,95}),
              Rectangle(
                extent={{-106,78},{-26,58}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-116,-82},{-106,-82},{-76,-12},{-26,-12},{4,-82},{14,-82},{14,
                    -92},{-116,-92},{-116,-82}},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-204,42},{-136,-26}},lineColor={0,0,255}),
              Line(points={{-170,58},{-170,28},{-200,28},{-200,4}},  color={0,0,255}),
              Line(points={{-200,4},{-199,9},{-195,13},{-190,14},{-185,13},{-181,9},{-180,
                    4}},           color={0,0,255}),
              Line(points={{-180,4},{-179,9},{-175,13},{-170,14},{-165,13},{-161,9},{-160,
                    4}},       color={0,0,255}),
              Line(points={{-160,4},{-159,9},{-155,13},{-150,14},{-145,13},{-141,9},{-140,
                    4}},  color={0,0,255}),
              Line(points={{-170,-42},{-170,-12},{-140,-12},{-140,6}},color={0,
                    0,255})}));
      end SynGenwAVR;

      model SynGenw
        extends Interfaces.Generation;

        parameter Modelica.SIunits.Inertia J=1.5 "Rotor's moment of inertia";

        replaceable parameter Records.SynchronousMachine.SM100kVA SG_Data
          constrainedby Records.Base.Synch
          annotation (Placement(transformation(extent={{-38,-92},{-18,-72}})));

        Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_ElectricalExcited
          smee(
          fsNominal=SG_Data.fsNominal,
          Rs=SG_Data.Rs,
          TsRef=SG_Data.TsRef,
          Lssigma=SG_Data.Lssigma,
          phiMechanical(fixed=false),
          wMechanical(fixed=false),
          Lmd=SG_Data.Lmd,
          Lmq=SG_Data.Lmq,
          Lrsigmad=SG_Data.Lrsigmad,
          Lrsigmaq=SG_Data.Lrsigmaq,
          Rrd=SG_Data.Rrd,
          Rrq=SG_Data.Rrq,
          TrRef=SG_Data.TrRef,
          VsNominal=SG_Data.VsNominal,
          IeOpenCircuit=SG_Data.IeOpenCircuit,
          Re=SG_Data.Re,
          TeRef=SG_Data.TeRef,
          sigmae=SG_Data.sigmae,
          p=SG_Data.Poles,
          Jr=0.02,
          Js=0.29,
          useDamperCage=useDamperCage,
          statorCoreParameters(VRef=115),
          strayLoadParameters(IRef=100),
          brushParameters(ILinear=0.01),
          TsOperational=293.15,
          alpha20s=SG_Data.alpha20s,
          TrOperational=293.15,
          alpha20r=SG_Data.alpha20r,
          alpha20e(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TeOperational=293.15)
          annotation (Placement(transformation(extent={{-62,-20},{-42,0}})));

        Modelica.Electrical.Machines.Sensors.RotorDisplacementAngle
          rotorDisplacementAngle(p=SG_Data.Poles)
                                      annotation (Placement(transformation(
              origin={32,-10},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Machines.Utilities.TerminalBox terminalBox(
            terminalConnection="Y")
          annotation (Placement(transformation(extent={{-60,2},{-40,22}})));
        Modelica.Mechanics.Rotational.Sources.Speed speed(exact=false)
                                                          annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={80,0})));
        Modelica.Electrical.MultiPhase.Sensors.VoltageSensor voltageSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={28,30})));
        Modelica.Electrical.MultiPhase.Blocks.QuasiRMS rms annotation (Placement(
              transformation(
              extent={{-5,-5},{5,5}},
              rotation=180,
              origin={-21,19})));
        Modelica.Blocks.Math.Gain PerUnitConversion(k=1/SG_Data.VsNominal)
                                                                        annotation (
           Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=90,
              origin={-122,34})));
        Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-100,-14})));
        Modelica.Electrical.Analog.Basic.Ground groundExcitation annotation (
            Placement(transformation(
              origin={-100,-58},
              extent={{-10,-10},{10,10}},
              rotation=0)));
        Modelica.Blocks.Math.Gain PerUnitConversion1(k=4)               annotation (
           Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=270,
              origin={2,70})));
        parameter Boolean useDamperCage=true "Enable / disable damper cage";
        Modelica.Electrical.Machines.Sensors.ElectricalPowerSensor powerSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-114,4})));
        Controls.CurCalc curCalc(machBase=SG_Data.SNominal, Vrated=SG_Data.VsNominal)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-132,66})));
        Modelica.Blocks.Math.Gain PerUnitConversion2(k=1/SG_Data.IeOpenCircuit)
                                                                        annotation (
           Placement(transformation(
              extent={{-4,-4},{4,4}},
              rotation=90,
              origin={-92,78})));
        Modelica.Electrical.Analog.Sensors.CurrentSensor currentSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-62,-34})));
        Modelica.Electrical.MultiPhase.Basic.Star Neutral annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-164,-34})));
      equation
        connect(rotorDisplacementAngle.plug_n,smee. plug_sn) annotation (Line(
              points={{38,-3.55271e-15},{38,10},{-58,10},{-58,0}},
                                                              color={0,0,255}));
        connect(rotorDisplacementAngle.plug_p,smee. plug_sp)
          annotation (Line(points={{26,0},{-46,0}},    color={0,0,255}));
        connect(terminalBox.plug_sn,smee. plug_sn) annotation (Line(
            points={{-56,6},{-56,0},{-58,0}},
            color={0,0,255}));
        connect(terminalBox.plug_sp,smee. plug_sp) annotation (Line(
            points={{-44,6},{-46,6},{-46,0}},
            color={0,0,255}));
        connect(smee.flange,rotorDisplacementAngle. flange) annotation (Line(
            points={{-42,-10},{22,-10}}));
        connect(voltageSensor.plug_p,rotorDisplacementAngle. plug_p)
          annotation (Line(points={{18,30},{18,0},{26,0}},   color={0,0,255}));
        connect(voltageSensor.plug_n,rotorDisplacementAngle. plug_n)
          annotation (Line(points={{38,30},{38,-3.55271e-15}},
                                                             color={0,0,255}));
        connect(rms.u,voltageSensor. v)
          annotation (Line(points={{-15,19},{28,19}},         color={0,0,127}));
        connect(speed.w_ref, w_ref) annotation (Line(points={{92,-2.22045e-15},
                {72,-2.22045e-15},{72,0},{100,0}},
                                 color={0,0,127}));
        connect(groundExcitation.p,signalVoltage. n) annotation (Line(points={{-100,
                -48},{-100,-24}},               color={0,0,255}));
        connect(powerSensor.plug_ni, AC_out)
          annotation (Line(points={{-124,4},{-176,4},{-176,2},{-222,2}},
                                                       color={0,0,255}));
        connect(powerSensor.plug_p, terminalBox.plugSupply) annotation (Line(
              points={{-104,4},{-76,4},{-76,8},{-50,8}},   color={0,0,255}));
        connect(curCalc.Q, powerSensor.Q) annotation (Line(points={{-132,56},{
                -140,56},{-140,-7},{-119,-7}},  color={0,0,127}));
        connect(curCalc.P, powerSensor.P) annotation (Line(points={{-139.8,56},
                {-130,56},{-130,-7},{-109,-7}},    color={0,0,127}));
        connect(smee.pin_ep, signalVoltage.p)
          annotation (Line(points={{-62,-4},{-100,-4}}, color={0,0,255}));
        connect(currentSensor.p, smee.pin_en)
          annotation (Line(points={{-62,-24},{-62,-16}}, color={0,0,255}));
        connect(currentSensor.n, signalVoltage.n) annotation (Line(points={{-62,
                -44},{-100,-44},{-100,-24}}, color={0,0,255}));
        connect(PerUnitConversion.y, curCalc.V) annotation (Line(points={{-122,
                38.4},{-122,56},{-124,56}}, color={0,0,127}));
        connect(signalVoltage.v, PerUnitConversion1.y) annotation (Line(points=
                {{-88,-14},{-88,65.6},{2,65.6}}, color={0,0,127}));
        connect(PerUnitConversion1.u, Efd) annotation (Line(points={{2,74.8},{2,
                74.8},{2,100}}, color={0,0,127}));
        connect(rotorDisplacementAngle.flange, speed.flange) annotation (Line(
              points={{22,-10},{46,-10},{46,8.88178e-16},{70,8.88178e-16}},
              color={0,0,0}));
        connect(rms.y, PerUnitConversion.u) annotation (Line(points={{-26.5,19},
                {-122,19},{-122,29.2}}, color={0,0,127}));
        connect(V, curCalc.V) annotation (Line(points={{-214,110},{-214,44},{
                -122,44},{-122,56},{-124,56}}, color={0,0,127}));
        connect(PerUnitConversion2.y, Ifd)
          annotation (Line(points={{-92,82.4},{-92,110}}, color={0,0,127}));
        connect(PerUnitConversion2.u, currentSensor.i) annotation (Line(points=
                {{-92,73.2},{-92,72},{-73,72},{-73,-34}}, color={0,0,127}));
        connect(Neutral.pin_n, signalVoltage.n) annotation (Line(points={{-164,
                -44},{-100,-44},{-100,-24}}, color={0,0,255}));
        connect(Neutral.plug_p, powerSensor.plug_nv) annotation (Line(points={{
                -164,-24},{-164,16},{-114,16},{-114,14}}, color={0,0,255}));
        connect(curCalc.Im, Im) annotation (Line(points={{-133.6,77},{-168.8,77},
                {-168.8,110},{-168,110}}, color={0,0,127}));
        connect(curCalc.Ia, Ia) annotation (Line(points={{-130,77},{-132,77},{
                -132,110}}, color={0,0,127}));
       annotation (Placement(visible=false,
            transformation(extent={{-70,8},{-70,8}}),
            iconTransformation(extent={{-70,8},{-70,8}})),
                    Icon(graphics={
              Rectangle(
                extent={{-106,68},{14,-52}},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={0,128,255}),
              Rectangle(
                extent={{-106,68},{-126,-52}},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={128,128,128}),
              Rectangle(
                extent={{14,12},{82,-8}},
                fillPattern=FillPattern.HorizontalCylinder,
                fillColor={95,95,95}),
              Rectangle(
                extent={{-106,78},{-26,58}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-116,-82},{-106,-82},{-76,-12},{-26,-12},{4,-82},{14,-82},{14,
                    -92},{-116,-92},{-116,-82}},
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{-204,42},{-136,-26}},lineColor={0,0,255}),
              Line(points={{-170,58},{-170,28},{-200,28},{-200,4}},  color={0,0,255}),
              Line(points={{-200,4},{-199,9},{-195,13},{-190,14},{-185,13},{-181,9},{-180,
                    4}},           color={0,0,255}),
              Line(points={{-180,4},{-179,9},{-175,13},{-170,14},{-165,13},{-161,9},{-160,
                    4}},       color={0,0,255}),
              Line(points={{-160,4},{-159,9},{-155,13},{-150,14},{-145,13},{-141,9},{-140,
                    4}},  color={0,0,255}),
              Line(points={{-170,-42},{-170,-12},{-140,-12},{-140,6}},color={0,
                    0,255})}));
      end SynGenw;
    end Generators;

    package Transformers
      model Ydd
        parameter Integer m=3 "Number of Phases";
        parameter Real R2 = 6.9143e-5 "Secondary Winding Resistance";
        parameter Real L2 = Modelica.Constants.eps "Secondary Winding Inductance";
        parameter Real R1 = 0.0019048 "Primary Winding Resistance";
        parameter Real L1 = Modelica.Constants.eps "Primary Winding Inductance";
        parameter Real Rm = 4761.9 "Magnetization Resistance";
        parameter Real Lm = 12.631 "Magnetization Inductance";
        parameter Real N = 200/(22*sqrt(3)) "Transformer Turn Ratio";

        Modelica.Electrical.MultiPhase.Basic.Star
                   starT(m=m) annotation (Placement(transformation(
              origin={-46,-44},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Delta
                    deltaT2(m=m) annotation (Placement(transformation(
              origin={28,44},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundT annotation (Placement(
              transformation(extent={{-56,-80},{-36,-60}})));
        Modelica.Electrical.MultiPhase.Basic.Resistor R_sec1(m=m, R={R2,R2,R2})
          annotation (Placement(transformation(extent={{-14,44},{6,64}})));
        Modelica.Electrical.MultiPhase.Basic.Delta
                    deltaT1(m=m) annotation (Placement(transformation(
              origin={28,14},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Resistor R_sec2(m=m, R={R2,R2,R2})
          annotation (Placement(transformation(extent={{-14,14},{6,34}})));
        Modelica.Electrical.MultiPhase.Basic.Resistor R_pr(m=m, R={R1,R1,R1})
          annotation (Placement(transformation(extent={{-114,30},{-94,50}})));
        Modelica.Electrical.MultiPhase.Basic.Resistor R_m(m=m, R={Rm,Rm,Rm})
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-62,20})));
        Modelica.Electrical.Machines.BasicMachines.Components.IdealCore
                                                    core(
          final m=m,
          final n12=N,
          final n13=N)  annotation (Placement(transformation(extent={{-46,20},{
                  -26,40}})));
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug Primary
          annotation (Placement(transformation(extent={{-172,-10},{-152,10}})));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug Secondary1
          annotation (Placement(transformation(extent={{94,50},{114,70}})));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug Secondary2
          annotation (Placement(transformation(extent={{94,-70},{114,-50}})));
      equation
        connect(groundT.p,starT. pin_n)
          annotation (Line(points={{-46,-60},{-46,-54}}, color={0,0,255}));
        connect(core.plug_p2, R_sec1.plug_p) annotation (Line(points={{-26,40},
                {-26,54},{-14,54}}, color={0,0,255}));
        connect(deltaT2.plug_n, core.plug_n2)
          annotation (Line(points={{28,34},{-26,34}}, color={0,0,255}));
        connect(R_sec2.plug_p, core.plug_p3) annotation (Line(points={{-14,24},
                {-20,24},{-20,26},{-26,26}}, color={0,0,255}));
        connect(R_sec1.plug_n, deltaT2.plug_p)
          annotation (Line(points={{6,54},{28,54}}, color={0,0,255}));
        connect(deltaT1.plug_p, R_sec2.plug_n)
          annotation (Line(points={{28,24},{6,24}}, color={0,0,255}));
        connect(deltaT1.plug_n, core.plug_n3)
          annotation (Line(points={{28,4},{-26,4},{-26,20}}, color={0,0,255}));
        connect(R_pr.plug_n, core.plug_p1)
          annotation (Line(points={{-94,40},{-46,40}}, color={0,0,255}));
        connect(R_m.plug_p, core.plug_p1) annotation (Line(points={{-62,30},{
                -62,40},{-46,40}}, color={0,0,255}));
        connect(core.plug_n1, starT.plug_p)
          annotation (Line(points={{-46,20},{-46,-34}}, color={0,0,255}));
        connect(R_m.plug_n, starT.plug_p) annotation (Line(points={{-62,10},{
                -46,10},{-46,-34}},
                               color={0,0,255}));
        connect(R_pr.plug_p, Primary) annotation (Line(points={{-114,40},{-136,
                40},{-136,0},{-162,0}}, color={0,0,255}));
        connect(deltaT2.plug_p, Secondary1) annotation (Line(points={{28,54},{
                66,54},{66,60},{104,60}}, color={0,0,255}));
        connect(deltaT1.plug_p, Secondary2) annotation (Line(points={{28,24},{
                62,24},{62,-60},{104,-60}}, color={0,0,255}));
        connect(Primary, Primary)
          annotation (Line(points={{-162,0},{-162,0}}, color={0,0,255}));
        annotation (
          Diagram(coordinateSystem(extent={{-160,-100},{100,100}})),
          Icon(coordinateSystem(extent={{-160,-100},{100,100}}), graphics={
                                   Polygon(
                    points={{-92,62},{-72,42},{-72,-38},{-92,-58},{-92,62}},
                    fillColor={135,135,135},
                    fillPattern=FillPattern.VerticalCylinder),Polygon(
                    points={{48,62},{28,42},{28,-38},{48,-58},{48,62}},
                    fillColor={135,135,135},
                    fillPattern=FillPattern.VerticalCylinder),Polygon(
                    points={{-22,52},{-32,42},{-32,-38},{-22,-48},{-12,-38},{
                    -12,42},{-22,52}},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={135,135,135}),Polygon(
                    points={{-92,62},{48,62},{28,42},{-12,42},{-22,52},{-32,42},
                    {-72,42},{-92,62}},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={135,135,135}),Polygon(
                    points={{-92,-58},{48,-58},{28,-38},{-12,-38},{-22,-48},{
                    -32,-38},{-72,-38},{-92,-58}},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={135,135,135}),Rectangle(
                    extent={{-100,38},{-64,-34}},
                    lineColor={128,0,255},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={128,0,255}),Rectangle(
                    extent={{-106,30},{-58,-26}},
                    lineColor={0,128,255},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={0,128,255}),Rectangle(
                    extent={{-40,38},{-4,-34}},
                    lineColor={128,0,255},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={128,0,255}),Rectangle(
                    extent={{-46,30},{2,-26}},
                    lineColor={0,128,255},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={0,128,255}),Rectangle(
                    extent={{20,38},{56,-34}},
                    lineColor={128,0,255},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={128,0,255}),Rectangle(
                    extent={{14,30},{62,-26}},
                    lineColor={0,128,255},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={0,128,255}),
                                        Text(
                    extent={{128,-58},{-172,-98}},
                textString="Ydd
",              lineColor={0,0,0}),            Text(
                    extent={{128,102},{-172,62}},
                    lineColor={0,0,255},
                    textString="%name"),       Rectangle(
                extent={{-124,104},{80,-100}},
                lineColor={255,0,0},
                pattern=LinePattern.Dash,
                lineThickness=0.5)}),
          experiment(
            __Dymola_NumberOfIntervals=50000,
            Tolerance=1e-05,
            __Dymola_fixedstepsize=1e-05,
            __Dymola_Algorithm="Dassl"));
      end Ydd;

      model Yd
        parameter Integer m=3 "Number of Phases";
        parameter Real R2 = 6.9143e-5 "Secondary Winding Resistance";
        parameter Real L2 = Modelica.Constants.eps "Secondary Winding Inductance";
        parameter Real R1 = 0.0019048 "Primary Winding Resistance";
        parameter Real L1 = Modelica.Constants.eps "Primary Winding Inductance";
        parameter Real Rm = 4761.9 "Magnetization Resistance";
        parameter Real Lm = 12.631 "Magnetization Inductance";
        parameter Real N = 200/(22*sqrt(3)) "Transformer Turn Ratio";

        Modelica.Electrical.MultiPhase.Basic.Star
                   starT(m=m) annotation (Placement(transformation(
              origin={-46,-44},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Electrical.MultiPhase.Basic.Delta
                    deltaT2(m=m) annotation (Placement(transformation(
              origin={34,30},
              extent={{-10,10},{10,-10}},
              rotation=270)));
        Modelica.Electrical.Analog.Basic.Ground groundT annotation (Placement(
              transformation(extent={{-56,-80},{-36,-60}})));
        Modelica.Electrical.MultiPhase.Basic.Resistor R_sec1(m=m, R=fill(R2, m))
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        Modelica.Electrical.MultiPhase.Basic.Resistor R_pr(m=m, R=fill(R1, m))
          annotation (Placement(transformation(extent={{-114,30},{-94,50}})));
        Modelica.Electrical.MultiPhase.Basic.Resistor R_m(m=m, R=fill(Rm, m))
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-74,20})));
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug Primary
          annotation (Placement(transformation(extent={{-172,-10},{-152,10}})));
        Modelica.Electrical.MultiPhase.Interfaces.NegativePlug Secondary1
          annotation (Placement(transformation(extent={{94,-10},{114,10}})));
        Modelica.Electrical.MultiPhase.Ideal.IdealTransformer
                               idealTransformer(
          m=m,
          Lm1=fill(Lm, m),
          n=fill(N, m))  annotation (Placement(transformation(extent={{-42,20},
                  {-22,40}})));
      equation
        connect(groundT.p,starT. pin_n)
          annotation (Line(points={{-46,-60},{-46,-54}}, color={0,0,255}));
        connect(R_sec1.plug_n, deltaT2.plug_p)
          annotation (Line(points={{10,40},{34,40}},color={0,0,255}));
        connect(R_m.plug_n, starT.plug_p) annotation (Line(points={{-74,10},{
                -46,10},{-46,-34}},
                               color={0,0,255}));
        connect(R_pr.plug_p, Primary) annotation (Line(points={{-114,40},{-136,
                40},{-136,0},{-162,0}}, color={0,0,255}));
        connect(deltaT2.plug_p, Secondary1) annotation (Line(points={{34,40},{
                66,40},{66,0},{104,0}},   color={0,0,255}));
        connect(Primary, Primary)
          annotation (Line(points={{-162,0},{-162,0}}, color={0,0,255}));
        connect(idealTransformer.plug_p2, R_sec1.plug_p)
          annotation (Line(points={{-22,40},{-10,40}}, color={0,0,255}));
        connect(idealTransformer.plug_p1, R_pr.plug_n)
          annotation (Line(points={{-42,40},{-94,40}}, color={0,0,255}));
        connect(idealTransformer.plug_n1, starT.plug_p) annotation (Line(points=
               {{-42,20},{-46,20},{-46,-34}}, color={0,0,255}));
        connect(idealTransformer.plug_n2, deltaT2.plug_n)
          annotation (Line(points={{-22,20},{34,20}}, color={0,0,255}));
        connect(R_m.plug_p, R_pr.plug_n) annotation (Line(points={{-74,30},{-74,
                40},{-94,40}}, color={0,0,255}));
        annotation (
          Diagram(coordinateSystem(extent={{-160,-100},{100,100}})),
          Icon(coordinateSystem(extent={{-160,-100},{100,100}}), graphics={
                                   Polygon(
                    points={{-92,62},{-72,42},{-72,-38},{-92,-58},{-92,62}},
                    fillColor={135,135,135},
                    fillPattern=FillPattern.VerticalCylinder),Polygon(
                    points={{48,62},{28,42},{28,-38},{48,-58},{48,62}},
                    fillColor={135,135,135},
                    fillPattern=FillPattern.VerticalCylinder),Polygon(
                    points={{-22,52},{-32,42},{-32,-38},{-22,-48},{-12,-38},{
                    -12,42},{-22,52}},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={135,135,135}),Polygon(
                    points={{-92,62},{48,62},{28,42},{-12,42},{-22,52},{-32,42},
                    {-72,42},{-92,62}},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={135,135,135}),Polygon(
                    points={{-92,-58},{48,-58},{28,-38},{-12,-38},{-22,-48},{
                    -32,-38},{-72,-38},{-92,-58}},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={135,135,135}),Rectangle(
                    extent={{-100,38},{-64,-34}},
                    lineColor={128,0,255},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={128,0,255}),Rectangle(
                    extent={{-106,30},{-58,-26}},
                    lineColor={0,128,255},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={0,128,255}),Rectangle(
                    extent={{-40,38},{-4,-34}},
                    lineColor={128,0,255},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={128,0,255}),Rectangle(
                    extent={{-46,30},{2,-26}},
                    lineColor={0,128,255},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={0,128,255}),Rectangle(
                    extent={{20,38},{56,-34}},
                    lineColor={128,0,255},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={128,0,255}),Rectangle(
                    extent={{14,30},{62,-26}},
                    lineColor={0,128,255},
                    fillPattern=FillPattern.VerticalCylinder,
                    fillColor={0,128,255}),
                                        Text(
                    extent={{128,-58},{-172,-98}},
                textString="Ydd
",              lineColor={0,0,0}),            Text(
                    extent={{128,102},{-172,62}},
                    lineColor={0,0,255},
                    textString="%name"),       Rectangle(
                extent={{-124,104},{80,-100}},
                lineColor={255,0,0},
                pattern=LinePattern.Dash,
                lineThickness=0.5)}),
          experiment(
            __Dymola_NumberOfIntervals=50000,
            Tolerance=1e-05,
            __Dymola_fixedstepsize=1e-05,
            __Dymola_Algorithm="Dassl"));
      end Yd;
    end Transformers;

    package Interfaces

      partial model Generation
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug AC_out annotation (
            Placement(transformation(rotation=0, extent={{-232,-8},{-212,12}})));
        Modelica.Blocks.Interfaces.RealInput w_ref(unit="rad/s") annotation (
            Placement(transformation(rotation=0, extent={{90,-10},{110,10}}),
              iconTransformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Interfaces.RealInput Efd(unit="rad/s") annotation (
            Placement(transformation(
              rotation=270,
              extent={{-10,-10},{10,10}},
              origin={2,100}), iconTransformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={42,90})));
        Modelica.Blocks.Interfaces.RealOutput Im annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-168,110})));
        Modelica.Blocks.Interfaces.RealOutput Ia annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-132,110})));
        Modelica.Blocks.Interfaces.RealOutput Ifd annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-92,110})));
        Modelica.Blocks.Interfaces.RealOutput V annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-214,110})));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                  -220,-100},{100,100}})),                             Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-220,-100},{
                  100,100}})));
      end Generation;

      partial model Loads
        Modelica.Electrical.MultiPhase.Interfaces.PositivePlug AC_in annotation (
            Placement(transformation(rotation=0, extent={{-110,-10},{-90,10}})));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)));
      end Loads;

      partial model Controller
        parameter Real Ref;
        Modelica.Blocks.Interfaces.RealInput Measurement
          annotation (Placement(transformation(extent={{-300,-20},{-260,20}})));
        Modelica.Blocks.Interfaces.RealOutput Actuation
          annotation (Placement(transformation(extent={{100,-10},{120,10}})));
        Modelica.Blocks.Interfaces.RealInput Aux_1 annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-190,-100})));
        Modelica.Blocks.Interfaces.RealInput Aux_2 annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-98,-100})));
        Modelica.Blocks.Interfaces.RealInput Aux_3 annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-100})));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{
                  -280,-100},{100,100}})),                             Diagram(
              coordinateSystem(preserveAspectRatio=false, extent={{-280,-100},{
                  100,100}})));
      end Controller;

    end Interfaces;

    package Load_Temp
      model DC_Load
        parameter Integer m=3 "Number of Phases";
        parameter Real R2 = 6.9143e-5 "Secondary Winding Resistance";
        parameter Real L2 = Modelica.Constants.eps "Secondary Winding Inductance";
        parameter Real R1 = 0.0019048 "Primary Winding Resistance";
        parameter Real L1 = Modelica.Constants.eps "Primary Winding Inductance";
        parameter Real Rm = 4761.9 "Magnetization Resistance";
        parameter Real Lm = 12.631 "Magnetization Inductance";
        parameter Real N = 200/(22*sqrt(3)) "Transformer Turn Ratio";
        parameter Real C = 1e-6 "AC Side Shunt Capacitor";
        extends Interfaces.Loads;
        Transformers.Yd yd
          annotation (Placement(transformation(extent={{-72,-10},{-46,10}})));
        Conversion.ACDC.Ret_AVG_Simulink ret_AVG_Simulink
          annotation (Placement(transformation(extent={{-26,-8},{-10,8}})));
      equation
        connect(ret_AVG_Simulink.AC, yd.Secondary1)
          annotation (Line(points={{-27,0},{-45.6,0}}, color={0,0,255}));
        connect(yd.Primary, AC_in)
          annotation (Line(points={{-72.2,0},{-100,0}}, color={0,0,255}));
      end DC_Load;

      model Fuel_Pump
        extends AircraftPowerSystem.Components.Load_Temp.DC_Load(
            ret_AVG_Simulink(P_fixed=P_fixed, V_rated=V_rated), yd(N=N));

        parameter Modelica.SIunits.Torque L=-L
          "Nominal torque (if negative, torque is acting as load)";
        replaceable Records.DCMotor.FuelPumps.FuelPump_2 Data(J=0.001)
                                                              constrainedby
          Records.Base.DC_Motor_Data
          annotation (Placement(transformation(extent={{92,-80},{112,-60}})));
        parameter Modelica.SIunits.Power P_fixed = 50;
        parameter Modelica.SIunits.Voltage V_rated = 28;
        parameter Modelica.SIunits.Resistance R = 0.5
          "Resistance of Auxillary Loads (Ohms)";
        Modelica.Electrical.Analog.Basic.Resistor DC_Load_Lamp(R=1)
          annotation (Placement(transformation(extent={{20,-48},{40,-28}})));
        Modelica.Electrical.Analog.Basic.Resistor DC_Load_Heater(R=1)
          annotation (Placement(transformation(extent={{20,-76},{40,-56}})));
        Modelica.Electrical.MultiPhase.Basic.Star star2 annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-34,-54})));
        Modelica.Electrical.Analog.Basic.Ground ground2
          annotation (Placement(transformation(extent={{-44,-94},{-24,-74}})));
        Modelica.Electrical.MultiPhase.Basic.Capacitor SmoothingCapacitor(C={1e-6,
              1e-6,1e-6}) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-34,-30})));
        Modelica.Electrical.Analog.Basic.Resistor Fuel_Pump(R=2.61)
          annotation (Placement(transformation(extent={{20,-28},{40,-8}})));
      equation
        connect(DC_Load_Lamp.n,DC_Load_Heater. n)
          annotation (Line(points={{40,-38},{60,-38},{60,-66},{40,-66}},
                                                       color={0,0,255}));
        connect(DC_Load_Lamp.n, ret_AVG_Simulink.v_ref) annotation (Line(points={{40,-38},
                {60,-38},{60,0},{-8.8,0}},              color={0,0,255}));
        connect(DC_Load_Lamp.p, ret_AVG_Simulink.DC_n) annotation (Line(points={{20,-38},
                {6,-38},{6,-7},{-9.4,-7}},           color={0,0,255}));
        connect(SmoothingCapacitor.plug_n, star2.plug_p)
          annotation (Line(points={{-34,-40},{-34,-44}}, color={0,0,255}));
        connect(ground2.p,star2. pin_n)
          annotation (Line(points={{-34,-74},{-34,-64}},
                                                       color={0,0,255}));
        connect(SmoothingCapacitor.plug_p, yd.Secondary1) annotation (Line(
              points={{-34,-20},{-34,0},{-45.6,0}}, color={0,0,255}));
        connect(DC_Load_Heater.p, ret_AVG_Simulink.DC_n) annotation (Line(
              points={{20,-66},{6,-66},{6,-7},{-9.4,-7}}, color={0,0,255}));
        connect(Fuel_Pump.n, ret_AVG_Simulink.v_ref) annotation (Line(points={{
                40,-18},{60,-18},{60,0},{-8.8,0}}, color={0,0,255}));
        connect(Fuel_Pump.p, ret_AVG_Simulink.DC_n) annotation (Line(points={{
                20,-18},{6,-18},{6,-7},{-9.4,-7}}, color={0,0,255}));
        annotation (Diagram(coordinateSystem(extent={{-100,-100},{140,100}})), Icon(
              coordinateSystem(extent={{-100,-100},{140,100}})));
      end Fuel_Pump;

      model PMSM
        parameter Modelica.SIunits.Power P_fixed = 1;
        parameter Modelica.SIunits.Voltage V_rated = 200;
        parameter Real L = -0.2 "Slope of Linear Speed to Torque Load";
        extends AircraftPowerSystem.Components.Load_Temp.DC_Load(
            ret_AVG_Simulink(P_fixed=P_fixed, V_rated=V_rated), yd(
            L2=1e-6,
            L1=1e-6,                                               N=N));
        Conversion.ACDC.Ret_AVG_Simulink            ret_AVG_Simulink1(P_fixed=
              P_fixed, V_rated=V_rated)
          annotation (Placement(transformation(extent={{-26,28},{-10,44}})));
        Conversion.DCAC.AvgInverter                                avgInverter
          annotation (Placement(transformation(extent={{100,14},{126,46}})));
        Modelica.Mechanics.Rotational.Sensors.AngleSensor angleSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={228,38})));
        Modelica.Electrical.MultiPhase.Sensors.CurrentSensor currentSensor(m=3)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={144,4})));
        Modelica.Electrical.Machines.BasicMachines.SynchronousInductionMachines.SM_PermanentMagnet
          smpm(
          phiMechanical(start=0, fixed=false),
          wMechanical(start=0, fixed=false),
          useSupport=false,
          useThermalPort=false,
          p=smpmData.p,
          fsNominal=smpmData.fsNominal,
          Rs=smpmData.Rs,
          TsRef=smpmData.TsRef,
          Lszero=smpmData.Lszero,
          Lssigma=smpmData.Lssigma,
          Jr=smpmData.Jr,
          Js=smpmData.Js,
          frictionParameters=smpmData.frictionParameters,
          statorCoreParameters=smpmData.statorCoreParameters,
          strayLoadParameters=smpmData.strayLoadParameters,
          ir(fixed=false),
          VsOpenCircuit=smpmData.VsOpenCircuit,
          Lmd=smpmData.Lmd,
          Lmq=smpmData.Lmq,
          useDamperCage=smpmData.useDamperCage,
          Lrsigmad=smpmData.Lrsigmad,
          Lrsigmaq=smpmData.Lrsigmaq,
          Rrd=smpmData.Rrd,
          Rrq=smpmData.Rrq,
          TrRef=smpmData.TrRef,
          permanentMagnetLossParameters=smpmData.permanentMagnetLossParameters,
          TsOperational=293.15,
          alpha20s=smpmData.alpha20s,
          TrOperational=293.15,
          alpha20r=smpmData.alpha20r) annotation (Placement(transformation(
                extent={{180,-56},{200,-36}})));
        AircraftPowerSystem.Controls.PMSM.SpeedController speedController(
          p=smpm.p,
          fsNominal=smpm.fsNominal,
          VsOpenCircuit=smpm.VsOpenCircuit,
          Rs=Modelica.Electrical.Machines.Thermal.convertResistance(
                    smpm.Rs,
                    smpm.TsRef,
                    smpm.alpha20s,
                    smpm.TsOperational),
          Ld=smpm.Lssigma + smpm.Lmd,
          Lq=smpm.Lssigma + smpm.Lmq,
          decoupling=true,
          Iqmax=200) annotation (Placement(transformation(
              extent={{-25,-16},{25,16}},
              rotation=0,
              origin={25,114})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=180,
              origin={218,78})));
        Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=180,
              origin={36,60})));
        Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
          linearSpeedDependentTorque(tau_nominal=-0.2,
          TorqueDirection=false,                       w_nominal=1)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=180,
              origin={264,-44})));
        replaceable parameter
                  Records.PMSM.PMSM_2kVA smpmData constrainedby
          Records.PMSM.PSM
          annotation (Placement(transformation(extent={{78,-88},{98,-68}})));
        Modelica.Blocks.Interfaces.RealInput Ref annotation (Placement(transformation(
              origin={-100,120},
              extent={{20,-20},{-20,20}},
              rotation=180), iconTransformation(
              extent={{20,-20},{-20,20}},
              rotation=180,
              origin={-80,82})));
        Modelica.Electrical.MultiPhase.Basic.Star star3(final m=3)
                                                                  annotation (
            Placement(transformation(extent={{10,-10},{-10,10}},
              rotation=90,
              origin={144,-46})));
        Modelica.Electrical.Analog.Basic.Ground GND annotation (Placement(
              transformation(
              origin={144,-86},
              extent={{-10,-10},{10,10}},
              rotation=0)));
        Modelica.Electrical.Machines.Sensors.ElectricalPowerSensor powerSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={172,-18})));
        Modelica.Blocks.Continuous.FirstOrder Filter(T=0.01)
                                                            annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-44,124})));
        Modelica.Electrical.MultiPhase.Basic.Star star1(final m=3)
                                                                  annotation (
            Placement(transformation(extent={{10,-10},{-10,10}},
              rotation=90,
              origin={-36,-42})));
        Modelica.Electrical.MultiPhase.Basic.Capacitor capacitor(C=fill(1e-9, 3))
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-36,-18})));
        Modelica.Electrical.Analog.Basic.Ground GND1
                                                    annotation (Placement(
              transformation(
              origin={-36,-80},
              extent={{-10,-10},{10,10}},
              rotation=0)));
      equation
        connect(ret_AVG_Simulink1.AC, yd.Secondary1) annotation (Line(points={{-27,36},
                {-30,36},{-30,0},{-45.6,0}}, color={0,0,255}));
        connect(speedController.a,avgInverter. ma) annotation (Line(points={{51.0417,
                128.255},{51.0417,122.454},{104.4,122.454},{104.4,44.2}},
                                                                        color={0,0,127}));
        connect(speedController.b,avgInverter. mb) annotation (Line(points={{51.0417,
                115.455},{51.0417,114.273},{114,114.273},{114,44.2}}, color={0,0,127}));
        connect(speedController.c,avgInverter. mc) annotation (Line(points={{51.0417,
                99.4545},{51.0417,107.273},{124,107.273},{124,44.2}},   color={0,0,127}));
        connect(angleSensor.phi,speedController. phi) annotation (Line(points={{228,49},
                {26,49},{26,100.909},{25.2083,100.909}},
                                                 color={0,0,127}));
        connect(currentSensor.i,speedController. iActual) annotation (Line(points={{133,4},
                {12.7083,4},{12.7083,100.909}},            color={0,0,127}));
        connect(voltageSensor.p, ret_AVG_Simulink1.DC_p) annotation (Line(points={{46,60},
                {90,60},{90,43},{-9,43}},       color={0,0,255}));
        connect(voltageSensor.n, ret_AVG_Simulink1.v_ref) annotation (Line(points={{26,60},
                {20,60},{20,36},{-8.8,36}},       color={0,0,255}));
        connect(avgInverter.pin_n1, ret_AVG_Simulink.DC_n) annotation (Line(points={{99,16.2},
                {78,16.2},{78,-7},{-9.4,-7}},   color={0,0,255}));
        connect(angleSensor.flange, smpm.flange) annotation (Line(points={{228,28},
                {228,-46},{200,-46}},     color={0,0,0}));
        connect(GND.p, star3.pin_n)
          annotation (Line(points={{144,-76},{144,-56}}, color={0,0,255}));
        connect(voltageSensor.v, speedController.Vdc1) annotation (Line(points={{36,71},
                {36.875,71},{36.875,100.909}},             color={0,0,127}));
        connect(speedSensor.w, speedController.Speed) annotation (Line(points={{207,78},
                {-12.5,78},{-12.5,115.455},{2.08333,115.455}},          color={
                0,0,127}));
        connect(avgInverter.pin_p, ret_AVG_Simulink1.DC_p) annotation (Line(
              points={{99,43.2},{62,43.2},{62,43},{-9,43}}, color={0,0,255}));
        connect(currentSensor.plug_p, avgInverter.positivePlug) annotation (
            Line(points={{144,14},{144,29.6},{127,29.6}}, color={0,0,255}));
        connect(smpm.plug_sn, star3.plug_p)
          annotation (Line(points={{184,-36},{144,-36}}, color={0,0,255}));
        connect(linearSpeedDependentTorque.flange, smpm.flange) annotation (
            Line(points={{254,-44},{226,-44},{226,-46},{200,-46}}, color={0,0,0}));
        connect(speedSensor.flange, smpm.flange) annotation (Line(points={{228,
                78},{236,78},{236,76},{242,76},{242,-44},{226,-44},{226,-46},{
                200,-46}}, color={0,0,0}));
        connect(powerSensor.plug_p, currentSensor.plug_n) annotation (Line(
              points={{162,-18},{154,-18},{154,-6},{144,-6}}, color={0,0,255}));
        connect(powerSensor.plug_nv, star3.plug_p) annotation (Line(points={{
                172,-28},{172,-36},{144,-36}}, color={0,0,255}));
        connect(powerSensor.plug_ni, smpm.plug_sp) annotation (Line(points={{
                182,-18},{196,-18},{196,-36}}, color={0,0,255}));
        connect(Filter.y, speedController.Ref) annotation (Line(points={{-33,124},
                {-14,124},{-14,127.382},{2.08333,127.382}},      color={0,0,127}));
        connect(Filter.u, Ref) annotation (Line(points={{-56,124},{-70,124},{
                -70,120},{-100,120}}, color={0,0,127}));
        connect(capacitor.plug_p, yd.Secondary1) annotation (Line(points={{-36,
                -8},{-36,0},{-45.6,0}}, color={0,0,255}));
        connect(star1.plug_p, capacitor.plug_n)
          annotation (Line(points={{-36,-32},{-36,-28}}, color={0,0,255}));
        connect(star1.pin_n, GND1.p)
          annotation (Line(points={{-36,-52},{-36,-70}}, color={0,0,255}));
        annotation (Diagram(coordinateSystem(extent={{-100,-100},{280,140}})), Icon(
              coordinateSystem(extent={{-100,-100},{280,140}})));
      end PMSM;

      model Induction_Motor
        extends Interfaces.Loads;
        parameter Real R_l "Aux AC Load Resistance";
        parameter Real L_l "Aux AC Load Inductance";
        Modelica.Electrical.Machines.BasicMachines.AsynchronousInductionMachines.AIM_SquirrelCage
          AC_Hydraulic_Pump(
          p=Data.p,
          fsNominal=Data.fsNominal,
          TsOperational=298.15,
          Rs=Data.Rs,
          TsRef=298.15,
          alpha20s(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          Lssigma=Data.Lss,
          Jr=Data.J,
          frictionParameters(
            PRef=0.000001,
            wRef=1.0471975511966e-7,
            power_w=0.000001),
          phiMechanical(fixed=true, start=0),
          wMechanical(start=0, fixed=true),
          statorCoreParameters(VRef=115),
          strayLoadParameters(power_w=0.00001),
          Lm=Data.Lm,
          Lrsigma=Data.Lr,
          Rr=Data.Rr,
          TrRef=298.15,
          alpha20r(displayUnit="1/K") = Modelica.Electrical.Machines.Thermal.Constants.alpha20Zero,
          TrOperational=298.15) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-28,-36})));

        Modelica.Electrical.MultiPhase.Basic.Star star(final m=3) annotation (
            Placement(transformation(extent={{10,-10},{-10,10}},
              rotation=0,
              origin={-50,-24})));
        Modelica.Electrical.Analog.Basic.Ground GND annotation (Placement(
              transformation(
              origin={-72,-24},
              extent={{-10,-10},{10,10}},
              rotation=270)));
        Modelica.Mechanics.Rotational.Sources.LinearSpeedDependentTorque
          HydraulicPumpLoad(
          useSupport=false,
          tau_nominal=-56/500,
          w_nominal=1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={12,-88})));
        Modelica.Electrical.MultiPhase.Ideal.IdealClosingSwitch switch
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
              origin={40,-22})));
        Modelica.Blocks.Sources.BooleanStep booleanStep(startTime=startTime,
            startValue=false)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-54,4})));
        Modelica.Blocks.Routing.BooleanReplicator booleanReplicator(nout=3)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
              origin={10,4})));
        parameter Modelica.SIunits.Time startTime=20
          "Time instant of Motor Connection";
          parameter Real L = -28/500
          "Mechanical Linear Load Slope";
        replaceable parameter Records.InductionMachine.IM_30KVA Data constrainedby
          Records.Base.IM
          annotation (Placement(transformation(extent={{-86,-78},{-66,-58}})));
        Controls.IM.VfController
                     vfController(
          T=0.1,
          VNominal=200,
          fNominal=600)
          annotation (Placement(transformation(extent={{-18,-18},{18,18}},
              rotation=0,
              origin={160,-22})));
        Modelica.Mechanics.Rotational.Sensors.SpeedSensor speedSensor1
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
              origin={114,-90})));
        Modelica.Blocks.Logical.Switch Startup annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={196,4})));
        Modelica.Blocks.Sources.Constant const(k=0)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={214,-52})));
        Conversion.DCAC.AvgInverter                                avgInverter1
          annotation (Placement(transformation(extent={{-13,-16},{13,16}},
              rotation=180,
              origin={75,76})));
        Conversion.ACDC.Ret_AVG_Simulink            ret_AVG_Simulink3(P_fixed=1,
            V_rated=200)
          annotation (Placement(transformation(extent={{-8,-8},{8,8}},
              rotation=180,
              origin={150,62})));
        Conversion.ACDC.Ret_AVG_Simulink            ret_AVG_Simulink4(P_fixed=1,
            V_rated=200)
          annotation (Placement(transformation(extent={{-8,-8},{8,8}},
              rotation=180,
              origin={150,84})));
        Modelica.Electrical.Analog.Sensors.VoltageSensor voltageSensor1
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=0,
              origin={120,68})));
        Modelica.Blocks.Interfaces.RealInput w annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={186,-100})));
        Modelica.Electrical.Machines.Sensors.ElectricalPowerSensor powerSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={14,-22})));
        Modelica.Blocks.Math.Add add
          annotation (Placement(transformation(extent={{94,-58},{114,-38}})));
        Modelica.Blocks.Continuous.TransferFunction Washout(b={0.02,0}, a={0.02,
              1})
          annotation (Placement(transformation(extent={{30,-62},{50,-42}})));
        Modelica.Blocks.Continuous.FirstOrder Filter(T=0.1) annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={168,28})));
        Generators.Controls.K_Sch k_Sch(
          k1=-0.03,
          k2=0,
          t=10)
          annotation (Placement(transformation(extent={{58,-62},{78,-42}})));
      equation
        connect(star.pin_n, GND.p)
          annotation (Line(points={{-60,-24},{-62,-24}}, color={0,0,255}));
        connect(AC_Hydraulic_Pump.plug_sn,star. plug_p)
          annotation (Line(points={{-34,-26},{-34,-24},{-40,-24}},
                                                            color={0,0,255}));
        connect(HydraulicPumpLoad.flange,AC_Hydraulic_Pump. flange) annotation (
            Line(points={{22,-88},{22,-36},{-18,-36}},     color={0,0,0}));
        connect(booleanReplicator.u,booleanStep. y)
          annotation (Line(points={{-2,4},{-43,4}},    color={255,0,255}));
        connect(booleanReplicator.y,switch. control) annotation (Line(points={{21,4},{
                40,4},{40,-10}},                  color={255,0,255}));
        connect(const.y,Startup. u3) annotation (Line(points={{214,-41},{214,
                -22},{204,-22},{204,-8}},
                               color={0,0,127}));
        connect(voltageSensor1.n, ret_AVG_Simulink3.v_ref) annotation (Line(
              points={{130,68},{138,68},{138,62},{140.8,62}}, color={0,0,255}));
        connect(ret_AVG_Simulink3.AC, ret_AVG_Simulink4.AC)
          annotation (Line(points={{159,62},{159,84}}, color={0,0,255}));
        connect(voltageSensor1.p, avgInverter1.pin_p) annotation (Line(points={
                {110,68},{104,68},{104,62.8},{89,62.8}}, color={0,0,255}));
        connect(avgInverter1.pin_n1, ret_AVG_Simulink4.DC_n) annotation (Line(
              points={{89,89.8},{118.5,89.8},{118.5,91},{141.4,91}}, color={0,0,
                255}));
        connect(ret_AVG_Simulink3.DC_p, avgInverter1.pin_p) annotation (Line(
              points={{141,55},{89,55},{89,62.8}}, color={0,0,255}));
        connect(voltageSensor1.v, vfController.V_DC) annotation (Line(points={{120,57},
                {120,44},{148,44},{148,-4},{164.8,-4}},           color={0,0,
                127}));
        connect(vfController.m_a, avgInverter1.ma) annotation (Line(points={{155.5,
                -4},{84,-4},{84,61.8},{83.6,61.8}},           color={0,0,127}));
        connect(vfController.m_b, avgInverter1.mb) annotation (Line(points={{158.5,
                -4},{74,-4},{74,61.8}},                     color={0,0,127}));
        connect(vfController.m_c, avgInverter1.mc) annotation (Line(points={{161.5,
                -4},{64,-4},{64,61.8}},                     color={0,0,127}));
        connect(Startup.u2, booleanStep.y) annotation (Line(points={{196,-8},{
                196,-70},{-8,-70},{-8,4},{-43,4}},
                                                color={255,0,255}));
        connect(w,Startup. u1) annotation (Line(points={{186,-100},{188,-100},{
                188,-8}}, color={0,0,127}));
        connect(speedSensor1.flange, AC_Hydraulic_Pump.flange) annotation (Line(
              points={{104,-90},{24,-90},{24,-36},{-18,-36}},color={0,0,0}));
        connect(switch.plug_n, avgInverter1.positivePlug) annotation (Line(
              points={{50,-22},{58,-22},{58,76.4},{61,76.4}}, color={0,0,255}));
        connect(powerSensor.plug_p, switch.plug_p)
          annotation (Line(points={{24,-22},{30,-22}}, color={0,0,255}));
        connect(powerSensor.plug_ni, AC_Hydraulic_Pump.plug_sp)
          annotation (Line(points={{4,-22},{4,-26},{-22,-26}},
                                                       color={0,0,255}));
        connect(powerSensor.plug_nv, star.plug_p) annotation (Line(points={{14,-12},
                {-34,-12},{-34,-24},{-40,-24}}, color={0,0,255}));
        connect(add.y, vfController.w_ref) annotation (Line(points={{115,-48},{
                120,-48},{120,-20.1143},{142,-20.1143}}, color={0,0,127}));
        connect(vfController.w_m, speedSensor1.w) annotation (Line(points={{142,
                -29.0286},{142,-28.5143},{125,-28.5143},{125,-90}}, color={0,0,
                127}));
        connect(AC_in, ret_AVG_Simulink4.AC) annotation (Line(points={{-100,0},
                {-100,98},{174,98},{174,74},{159,74},{159,84}}, color={0,0,255}));
        connect(Washout.u, powerSensor.P) annotation (Line(points={{28,-52},{19,
                -52},{19,-33}},          color={0,0,127}));
        connect(Filter.u, Startup.y) annotation (Line(points={{180,28},{196,28},
                {196,15}}, color={0,0,127}));
        connect(Filter.y, add.u1) annotation (Line(points={{157,28},{92,28},{92,
                -42}}, color={0,0,127}));
        connect(k_Sch.y, add.u2) annotation (Line(points={{79,-52},{86,-52},{86,
                -54},{92,-54}}, color={0,0,127}));
        connect(Washout.y, k_Sch.u)
          annotation (Line(points={{51,-52},{58,-52}}, color={0,0,127}));
        annotation (Diagram(coordinateSystem(extent={{-100,-100},{240,100}})),
            Icon(coordinateSystem(extent={{-100,-100},{240,100}})));
      end Induction_Motor;
    end Load_Temp;
  end Components;

  package Systems

    package Template

      model DistributionSystem_temp
        Modelica.Blocks.Sources.TimeTable timeTable(table=[0.0,0; 0.0001,11900;
              0.5,12000; 1,12000; 2,12000; 3,10000; 4.5,18000; 6,1; 6,0.0; 10,
              0.0], timeScale=3600)
                            annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={244,34})));
        Modelica.Blocks.Math.Gain RPMtoRPS(k=3.14/30) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={206,34})));
        replaceable Components.Interfaces.Generation generation annotation (
            Placement(transformation(
              extent={{-24,-13},{24,13}},
              rotation=0,
              origin={152,35})));
        replaceable Components.Interfaces.Loads DC_Load_1
          annotation (Placement(transformation(extent={{128,-12},{148,8}})));
        replaceable Components.Interfaces.Loads DC_Load_2
          annotation (Placement(transformation(extent={{128,-44},{148,-24}})));
        replaceable Components.Interfaces.Loads AC_Load annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={58,34})));
        replaceable Components.Interfaces.Controller AVR
          annotation (Placement(transformation(extent={{126,74},{172,94}})));
        replaceable Records.Base.AVR AVR_Data constrainedby Records.Base.AVR
          annotation (Placement(transformation(extent={{218,70},{238,90}})));
      equation
        connect(timeTable.y,RPMtoRPS. u)
          annotation (Line(points={{233,34},{218,34}},   color={0,0,127}));
        connect(generation.w_ref, RPMtoRPS.y)
          annotation (Line(points={{176,35},{194,35},{194,34},{195,34}},
                                                       color={0,0,127}));
        connect(AC_Load.AC_in, generation.AC_out) annotation (Line(points={{68,34},
                {80,34},{80,35.26},{127.7,35.26}},   color={0,0,255}));
        connect(DC_Load_1.AC_in, generation.AC_out) annotation (Line(points={{128,-2},
                {98,-2},{98,35.26},{127.7,35.26}},     color={0,0,255}));
        connect(DC_Load_2.AC_in, generation.AC_out) annotation (Line(points={{128,-34},
                {98,-34},{98,35.26},{127.7,35.26}},        color={0,0,255}));
        connect(AVR.Measurement, generation.V) annotation (Line(points={{126,84},
                {116,84},{116,49.3},{128.9,49.3}}, color={0,0,127}));
        connect(generation.Efd, AVR.Actuation) annotation (Line(points={{167.3,
                46.7},{167.3,60},{180,60},{180,84},{173.211,84}}, color={0,0,
                127}));
        connect(generation.Im, AVR.Aux_1) annotation (Line(points={{135.8,49.3},
                {135.8,60.65},{136.895,60.65},{136.895,74}}, color={0,0,127}));
        connect(generation.Ifd, AVR.Aux_3) annotation (Line(points={{147.2,49.3},
                {147.2,56},{160,56},{160,74},{159.895,74}}, color={0,0,127}));
        connect(generation.Ia, AVR.Aux_2) annotation (Line(points={{141.2,49.3},
                {141.2,62},{148.032,62},{148.032,74}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{40,-60},
                  {280,100}})),            Diagram(coordinateSystem(
                preserveAspectRatio=false, extent={{40,-60},{280,100}})));
      end DistributionSystem_temp;

      package Configurations
        model DistributionSystem_DC1_Simple
          Modelica.Blocks.Sources.TimeTable RPM_Engine(table=[0.0,0; 0.005,12000;
                0.01,17000; 0.015,12000; 0.03,12000; 0.04,10000; 0.05,18000; 0.07,
                1; 8,0.0; 10,0.0],
                      timeScale=3600) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={254,34})));
          Modelica.Blocks.Math.Gain RPMtoRPS(k=3.14/30) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={206,34})));
          replaceable Components.Generators.SynGenw    generation constrainedby
            Components.Interfaces.Generation                      annotation (
              Placement(transformation(
                extent={{-24,-13},{24,13}},
                rotation=0,
                origin={152,35})));
          replaceable Components.Load_Temp.Fuel_Pump DC_Loads constrainedby
            Components.Interfaces.Loads
            annotation (Placement(transformation(extent={{128,-12},{148,8}})));
          replaceable Components.Load_Temp.PMSM Ball_Screw_Actuator(N=1/1.6)
            constrainedby Components.Interfaces.Loads
            annotation (Placement(transformation(extent={{188,-46},{232,-28}})));
          replaceable Components.Load_Temp.Induction_Motor Hydraulic_Pump(
            R_l=0,
            L_l=0,
            startTime=3)  constrainedby Components.Interfaces.Loads annotation (
              Placement(transformation(
                extent={{-14,-13},{14,13}},
                rotation=180,
                origin={60,35})));
          replaceable Components.Generators.Controls.AVR_Type_DC1 AVR(
            Ref=1.02,
            T_R=AVR_Data.T_R,
            T_C=AVR_Data.T_C,
            T_B=AVR_Data.T_B,
            K_A=AVR_Data.K_A,
            T_A=AVR_Data.T_A,
            K_E=AVR_Data.K_E,
            T_E=AVR_Data.T_E,
            K_F=AVR_Data.K_F,
            T_F=AVR_Data.T_F,
            Vmax=AVR_Data.Vmax,
            Vmin=AVR_Data.Vmin,
            K_D=AVR_Data.K_D,
            K_C=AVR_Data.K_C,
            Efdmax=AVR_Data.Efdmax,
            Efdmin=AVR_Data.Efdmax,
            K_p=AVR_Data.K_p,
            K_i=AVR_Data.K_i,
            K_G=AVR_Data.K_G,
            K_M=AVR_Data.K_M,
            T_M=AVR_Data.T_M,
            V_Mmax=AVR_Data.V_Mmax,
            V_Mmin=AVR_Data.V_Mmin,
            X_L=AVR_Data.X_L,
            V_Gmax=AVR_Data.V_Gmax,
            th=AVR_Data.th,
            K_g=AVR_Data.K_G,
            V_Imax=AVR_Data.V_Imax,
            V_Imin=AVR_Data.V_Imax) constrainedby
            Components.Interfaces.Controller
            annotation (Placement(transformation(extent={{126,74},{172,94}})));
          replaceable Records.Controllers.TypeI_AVR AVR_Data(
            T_R=0.002,
            T_C=100,
            T_B=500)                                         constrainedby
            Records.Base.AVR
            annotation (Placement(transformation(extent={{218,70},{238,90}})));
          Modelica.Blocks.Sources.TimeTable RPM(table=[0.0,0; 0.005,251; 0.01,360;
                0.015,300; 0.03,300; 0.04,251; 0.05,360; 0.07,0; 6,0.0; 10,0.0],
              timeScale=3600) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={50,84})));
          Modelica.Electrical.MultiPhase.Basic.Star Neutral annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={80,-26})));
          Modelica.Electrical.Analog.Basic.Ground GND
            annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
          Modelica.Electrical.MultiPhase.Basic.Resistor AC_Load(R=fill(5, 3))
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={80,-6})));
          Modelica.Blocks.Sources.TimeTable BallScrewSpeedCommands(table=[0,0; 5,
                0; 7,90; 8,60; 10,-90; 12,0; 13,0; 14,100; 16,-100; 20,0; 21,50;
                23,-60; 24,0; 25,0; 26,80; 27,20; 28,-60; 30,0.0; 31,60; 33,-60;
                35,0.0; 38,30; 40,-40; 42,50; 44,-100; 45,0; 46,0], timeScale=1)
                                                      annotation (Placement(
                transformation(
                extent={{-13,-13},{13,13}},
                rotation=180,
                origin={201,-3})));
          Modelica.Electrical.MultiPhase.Basic.Inductor Inductive_AC_Load(L=fill(
                0.1, 3)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={54,-6})));
        equation
          connect(RPM_Engine.y, RPMtoRPS.u)
            annotation (Line(points={{243,34},{218,34}}, color={0,0,127}));
          connect(generation.w_ref, RPMtoRPS.y)
            annotation (Line(points={{176,35},{194,35},{194,34},{195,34}},
                                                         color={0,0,127}));
          connect(Hydraulic_Pump.AC_in, generation.AC_out) annotation (Line(
                points={{74,35},{80,35},{80,35.26},{127.7,35.26}}, color={0,0,255}));
          connect(DC_Loads.AC_in, generation.AC_out) annotation (Line(points={{
                  128,-2},{98,-2},{98,35.26},{127.7,35.26}}, color={0,0,255}));
          connect(Ball_Screw_Actuator.AC_in, generation.AC_out) annotation (Line(
                points={{188,-38.5},{98,-38.5},{98,35.26},{127.7,35.26}}, color={
                  0,0,255}));
          connect(AVR.Measurement, generation.V) annotation (Line(points={{126,84},
                  {116,84},{116,49.3},{128.9,49.3}}, color={0,0,127}));
          connect(generation.Efd, AVR.Actuation) annotation (Line(points={{167.3,
                  46.7},{167.3,60},{180,60},{180,84},{173.211,84}}, color={0,0,
                  127}));
          connect(generation.Im, AVR.Aux_1) annotation (Line(points={{135.8,
                  49.3},{135.8,60.65},{136.895,60.65},{136.895,74}},
                                                               color={0,0,127}));
          connect(generation.Ifd, AVR.Aux_3) annotation (Line(points={{147.2,
                  49.3},{147.2,56},{160,56},{160,74},{159.895,74}},
                                                              color={0,0,127}));
          connect(generation.Ia, AVR.Aux_2) annotation (Line(points={{141.2,
                  49.3},{141.2,62},{148.032,62},{148.032,74}},
                                                         color={0,0,127}));
          connect(RPM.y, Hydraulic_Pump.w) annotation (Line(points={{50,73},{50,
                  48},{50.4471,48}},         color={0,0,127}));
          connect(GND.p, Neutral.pin_n)
            annotation (Line(points={{80,-40},{80,-36}}, color={0,0,255}));
          connect(Neutral.plug_p, AC_Load.plug_n)
            annotation (Line(points={{80,-16},{80,-16}}, color={0,0,255}));
          connect(AC_Load.plug_p, generation.AC_out) annotation (Line(points={{80,4},{
                  98,4},{98,35.26},{127.7,35.26}},     color={0,0,255}));
          connect(BallScrewSpeedCommands.y, Ball_Screw_Actuator.Ref) annotation (
              Line(points={{186.7,-3},{174,-3},{174,-32.35},{190.316,-32.35}},
                color={0,0,127}));
          connect(Inductive_AC_Load.plug_p, AC_Load.plug_p)
            annotation (Line(points={{54,4},{80,4}}, color={0,0,255}));
          connect(Inductive_AC_Load.plug_n, AC_Load.plug_n)
            annotation (Line(points={{54,-16},{80,-16}}, color={0,0,255}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{20,-60},
                    {280,100}})),            Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{20,-60},{280,100}})),
            experiment(
              StopTime=60,
              Interval=0.001,
              Tolerance=1e-05,
              __Dymola_fixedstepsize=0.001,
              __Dymola_Algorithm="Dassl"),
            __Dymola_experimentFlags(
              Advanced(
                EvaluateAlsoTop=false,
                GenerateVariableDependencies=false,
                OutputModelicaCode=false),
              Evaluate=true,
              OutputCPUtime=false,
              OutputFlatModelica=false),
            __Dymola_experimentSetupOutput);
        end DistributionSystem_DC1_Simple;

        model DistributionSystem_DC1_SG_IG
          Modelica.Blocks.Sources.TimeTable RPM_Engine(table=[0.0,0; 0.01,11900;
                0.5,12000; 1,12000; 2,12000; 3,10000; 4.5,18000; 6,1; 6,0.0; 10,
                0.0], timeScale=3600) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={254,34})));
          Modelica.Blocks.Math.Gain RPMtoRPS(k=3.14/30) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={206,34})));
          replaceable Components.Generators.SynGenw    generation constrainedby
            Components.Interfaces.Generation                      annotation (
              Placement(transformation(
                extent={{-24,-13},{24,13}},
                rotation=0,
                origin={152,35})));
          replaceable Components.Load_Temp.Induction_Motor Hydraulic_Pump(
            R_l=0,
            L_l=0,
            startTime=40) constrainedby Components.Interfaces.Loads annotation (
              Placement(transformation(
                extent={{-14,-13},{14,13}},
                rotation=180,
                origin={60,35})));
          replaceable Components.Generators.Controls.AVR_Type_ST3 AVR(
            Ref=1.01,
            T_R=AVR_Data.T_R,
            T_C=AVR_Data.T_C,
            T_B=AVR_Data.T_B,
            K_A=AVR_Data.K_A,
            T_A=AVR_Data.T_A,
            K_E=AVR_Data.K_E,
            T_E=AVR_Data.T_E,
            K_F=AVR_Data.K_F,
            T_F=AVR_Data.T_F,
            Vmax=AVR_Data.Vmax,
            Vmin=AVR_Data.Vmin,
            K_D=AVR_Data.K_D,
            K_C=AVR_Data.K_C,
            Efdmax=AVR_Data.Efdmax,
            Efdmin=AVR_Data.Efdmax,
            K_p=AVR_Data.K_p,
            K_i=AVR_Data.K_i,
            K_G=AVR_Data.K_G,
            K_M=AVR_Data.K_M,
            T_M=AVR_Data.T_M,
            V_Mmax=AVR_Data.V_Mmax,
            V_Mmin=AVR_Data.V_Mmin,
            X_L=AVR_Data.X_L,
            V_Gmax=AVR_Data.V_Gmax,
            th=AVR_Data.th,
            V_Imax=AVR_Data.V_Imax,
            V_Imin=AVR_Data.V_Imin) constrainedby
            Components.Interfaces.Controller
            annotation (Placement(transformation(extent={{126,74},{172,94}})));
          replaceable Records.Controllers.AVR_ST3   AVR_Data(K_A=20)
                                                             constrainedby
            Records.Base.AVR
            annotation (Placement(transformation(extent={{218,70},{238,90}})));
          Modelica.Electrical.MultiPhase.Basic.Star Neutral annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={100,-26})));
          Modelica.Electrical.Analog.Basic.Ground GND
            annotation (Placement(transformation(extent={{90,-60},{110,-40}})));
          Modelica.Electrical.MultiPhase.Basic.Resistor AC_Load(R=fill(5, 3))
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={100,-6})));
          Modelica.Electrical.MultiPhase.Basic.Inductor Inductive_AC_Load(L=fill(
                0.1, 3)) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={76,-4})));
          Modelica.Blocks.Sources.TimeTable RPM(table=[0.0,0; 0.01,251; 0.5,361.8;
                1,251; 2,251; 3,251; 4.5,391.8; 6,0; 6,0.0; 10,0.0], timeScale=
                3600)         annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={56,82})));
        equation
          connect(RPM_Engine.y, RPMtoRPS.u)
            annotation (Line(points={{243,34},{218,34}}, color={0,0,127}));
          connect(generation.w_ref, RPMtoRPS.y)
            annotation (Line(points={{176,35},{194,35},{194,34},{195,34}},
                                                         color={0,0,127}));
          connect(Hydraulic_Pump.AC_in, generation.AC_out) annotation (Line(
                points={{74,35},{80,35},{80,35.26},{127.7,35.26}}, color={0,0,255}));
          connect(AVR.Measurement, generation.V) annotation (Line(points={{126,84},
                  {116,84},{116,49.3},{128.9,49.3}}, color={0,0,127}));
          connect(generation.Efd, AVR.Actuation) annotation (Line(points={{167.3,
                  46.7},{167.3,60},{180,60},{180,84},{173.211,84}}, color={0,0,
                  127}));
          connect(generation.Im, AVR.Aux_1) annotation (Line(points={{135.8,
                  49.3},{135.8,60.65},{136.895,60.65},{136.895,74}},
                                                               color={0,0,127}));
          connect(generation.Ifd, AVR.Aux_3) annotation (Line(points={{147.2,
                  49.3},{147.2,56},{156,56},{156,74},{159.895,74}},
                                                              color={0,0,127}));
          connect(generation.Ia, AVR.Aux_2) annotation (Line(points={{141.2,
                  49.3},{141.2,62},{148.032,62},{148.032,74}},
                                                         color={0,0,127}));
          connect(GND.p, Neutral.pin_n)
            annotation (Line(points={{100,-40},{100,-36}}, color={0,0,255}));
          connect(Neutral.plug_p, AC_Load.plug_n)
            annotation (Line(points={{100,-16},{100,-16}},
                                                         color={0,0,255}));
          connect(AC_Load.plug_p, generation.AC_out) annotation (Line(points={{100,4},
                  {100,35.26},{127.7,35.26}},          color={0,0,255}));
          connect(Inductive_AC_Load.plug_p, generation.AC_out) annotation (Line(
                points={{76,6},{76,12},{100,12},{100,35.26},{127.7,35.26}}, color=
                 {0,0,255}));
          connect(Inductive_AC_Load.plug_n, AC_Load.plug_n) annotation (Line(
                points={{76,-14},{76,-16},{100,-16}}, color={0,0,255}));
          connect(RPM.y, Hydraulic_Pump.w) annotation (Line(points={{56,71},{56,
                  48},{50.4471,48}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{40,-60},
                    {280,100}})),            Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{40,-60},{280,100}})),
            experiment(
              StopTime=50,
              Interval=0.0001,
              __Dymola_fixedstepsize=0.001,
              __Dymola_Algorithm="Dassl"),
            __Dymola_experimentFlags(Advanced(
                InlineMethod=0,
                InlineOrder=2,
                InlineFixedStep=0.001)));
        end DistributionSystem_DC1_SG_IG;

        model DistributionSystem_ST3
          Modelica.Blocks.Sources.TimeTable RPM_Engine(table=[0.0,0; 0.01,11900;
                0.5,12000; 1,12000; 2,12000; 3,10000; 4.5,18000; 6,1; 6,0.0; 10,
                0.0], timeScale=3600) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={254,34})));
          Modelica.Blocks.Math.Gain RPMtoRPS(k=3.14/30) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={206,34})));
          replaceable Components.Generators.SynGenw    generation constrainedby
            Components.Interfaces.Generation                      annotation (
              Placement(transformation(
                extent={{-24,-13},{24,13}},
                rotation=0,
                origin={152,35})));
          replaceable Components.Load_Temp.Fuel_Pump
                                                  Fuel_Pump constrainedby
            Components.Interfaces.Loads
            annotation (Placement(transformation(extent={{128,-12},{148,8}})));
          replaceable Components.Load_Temp.PMSM Ball_Screw_Actuator(N=1/1.6)
            constrainedby Components.Interfaces.Loads
            annotation (Placement(transformation(extent={{188,-46},{232,-28}})));
          replaceable Components.Load_Temp.Induction_Motor Hydraulic_Pump(
            R_l=0,
            L_l=0,
            startTime=10) constrainedby Components.Interfaces.Loads annotation (
              Placement(transformation(
                extent={{-14,-13},{14,13}},
                rotation=180,
                origin={60,35})));
          replaceable Components.Generators.Controls.AVR_Type_ST3 AVR(
            Ref=1.02,
            T_R=AVR_Data.T_R,
            T_C=AVR_Data.T_C,
            T_B=AVR_Data.T_B,
            K_A=AVR_Data.K_A,
            T_A=AVR_Data.T_A,
            K_E=AVR_Data.K_E,
            T_E=AVR_Data.T_E,
            K_F=AVR_Data.K_F,
            T_F=AVR_Data.T_F,
            Vmax=AVR_Data.Vmax,
            Vmin=AVR_Data.Vmin,
            K_D=AVR_Data.K_D,
            K_C=AVR_Data.K_C,
            Efdmax=AVR_Data.Efdmax,
            Efdmin=AVR_Data.Efdmax,
            K_p=AVR_Data.K_p,
            K_i=AVR_Data.K_i,
            K_G=AVR_Data.K_G,
            K_M=AVR_Data.K_M,
            T_M=AVR_Data.T_M,
            V_Mmax=AVR_Data.V_Mmax,
            V_Mmin=AVR_Data.V_Mmin,
            X_L=AVR_Data.X_L,
            V_Gmax=AVR_Data.V_Gmax,
            th=AVR_Data.th,
            V_Imax=AVR_Data.V_Imax,
            V_Imin=AVR_Data.V_Imax) constrainedby
            Components.Interfaces.Controller
            annotation (Placement(transformation(extent={{126,74},{172,94}})));
          replaceable Records.Controllers.AVR_ST3 AVR_Data constrainedby
            Records.Base.AVR
            annotation (Placement(transformation(extent={{218,70},{238,90}})));
          Modelica.Electrical.MultiPhase.Basic.Star Neutral annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={80,-26})));
          Modelica.Electrical.Analog.Basic.Ground ground5
            annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
          Modelica.Electrical.MultiPhase.Basic.Resistor AC_Load(R=fill(5, 3))
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={80,-6})));
          Modelica.Blocks.Sources.TimeTable BallScrewSpeedCommands(table=[0.0,0;
                2,0; 2.01,80; 3,60; 4,-80; 6,0; 10,40; 11,-40; 12,0; 15,0; 15.1,
                60; 16,-60; 20,0; 21,0], timeScale=5) annotation (Placement(
                transformation(
                extent={{-13,-13},{13,13}},
                rotation=180,
                origin={201,-3})));
          Modelica.Blocks.Sources.TimeTable RPM(table=[0.0,0; 0.01,251; 0.5,361.8;
                1,251; 2,251; 3,251; 4.5,391.8; 6,0; 6,0.0; 10,0.0], timeScale=
                3600)         annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={56,82})));
        equation
          connect(RPM_Engine.y, RPMtoRPS.u)
            annotation (Line(points={{243,34},{218,34}}, color={0,0,127}));
          connect(generation.w_ref, RPMtoRPS.y)
            annotation (Line(points={{176,35},{194,35},{194,34},{195,34}},
                                                         color={0,0,127}));
          connect(Hydraulic_Pump.AC_in, generation.AC_out) annotation (Line(
                points={{74,35},{80,35},{80,35.26},{127.7,35.26}}, color={0,0,255}));
          connect(Fuel_Pump.AC_in, generation.AC_out) annotation (Line(points={{128,-2},
                  {98,-2},{98,35.26},{127.7,35.26}},     color={0,0,255}));
          connect(Ball_Screw_Actuator.AC_in, generation.AC_out) annotation (Line(
                points={{188,-38.5},{98,-38.5},{98,35.26},{127.7,35.26}}, color={
                  0,0,255}));
          connect(AVR.Measurement, generation.V) annotation (Line(points={{126,84},
                  {116,84},{116,49.3},{128.9,49.3}}, color={0,0,127}));
          connect(generation.Efd, AVR.Actuation) annotation (Line(points={{167.3,
                  46.7},{167.3,60},{180,60},{180,84},{173.211,84}}, color={0,0,
                  127}));
          connect(generation.Im, AVR.Aux_1) annotation (Line(points={{135.8,
                  49.3},{135.8,60.65},{136.895,60.65},{136.895,74}},
                                                               color={0,0,127}));
          connect(generation.Ifd, AVR.Aux_3) annotation (Line(points={{147.2,
                  49.3},{147.2,56},{160,56},{160,74},{159.895,74}},
                                                              color={0,0,127}));
          connect(generation.Ia, AVR.Aux_2) annotation (Line(points={{141.2,
                  49.3},{141.2,62},{148.032,62},{148.032,74}},
                                                         color={0,0,127}));
          connect(ground5.p, Neutral.pin_n)
            annotation (Line(points={{80,-40},{80,-36}}, color={0,0,255}));
          connect(Neutral.plug_p, AC_Load.plug_n)
            annotation (Line(points={{80,-16},{80,-16}}, color={0,0,255}));
          connect(AC_Load.plug_p, generation.AC_out) annotation (Line(points={{80,
                  4},{98,4},{98,35.26},{127.7,35.26}}, color={0,0,255}));
          connect(BallScrewSpeedCommands.y, Ball_Screw_Actuator.Ref) annotation (
              Line(points={{186.7,-3},{174,-3},{174,-32.35},{190.316,-32.35}},
                color={0,0,127}));
          connect(RPM.y, Hydraulic_Pump.w) annotation (Line(points={{56,71},{56,
                  48},{50.4471,48}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{40,-60},
                    {280,100}})),            Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{40,-60},{280,100}})),
            experiment(StopTime=100, __Dymola_fixedstepsize=0.001),
            __Dymola_experimentFlags(Advanced(
                InlineMethod=2,
                InlineOrder=2,
                InlineFixedStep=0.001)));
        end DistributionSystem_ST3;

        model DistributionSystem_AC1
          Modelica.Blocks.Sources.TimeTable RPM_Engine(table=[0.0,0; 0.01,11900;
                0.5,12000; 1,12000; 2,12000; 3,10000; 4.5,18000; 6,1; 6,0.0; 10,
                0.0], timeScale=3600) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={254,34})));
          Modelica.Blocks.Math.Gain RPMtoRPS(k=3.14/30) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={206,34})));
          replaceable Components.Generators.SynGenw    generation constrainedby
            Components.Interfaces.Generation                      annotation (
              Placement(transformation(
                extent={{-24,-13},{24,13}},
                rotation=0,
                origin={152,35})));
          replaceable Components.Load_Temp.Fuel_Pump
                                                  Fuel_Pump constrainedby
            Components.Interfaces.Loads
            annotation (Placement(transformation(extent={{128,-12},{148,8}})));
          replaceable Components.Load_Temp.PMSM Ball_Screw_Actuator(N=1/1.6)
            constrainedby Components.Interfaces.Loads
            annotation (Placement(transformation(extent={{188,-46},{232,-28}})));
          replaceable Components.Load_Temp.Induction_Motor Hydraulic_Pump(
            R_l=0,
            L_l=0,
            startTime=10) constrainedby Components.Interfaces.Loads annotation (
              Placement(transformation(
                extent={{-14,-13},{14,13}},
                rotation=180,
                origin={60,35})));
          replaceable Components.Generators.Controls.AVR_AC AVR(
            Ref=1.02,
            T_R=AVR_Data.T_R,
            T_C=AVR_Data.T_C,
            T_B=AVR_Data.T_B,
            K_A=AVR_Data.K_A,
            T_A=AVR_Data.T_A,
            K_E=AVR_Data.K_E,
            T_E=AVR_Data.T_E,
            K_F=AVR_Data.K_F,
            T_F=AVR_Data.T_F,
            Vmax=AVR_Data.Vmax,
            Vmin=AVR_Data.Vmin,
            K_D=AVR_Data.K_D,
            K_C=AVR_Data.K_C,
            Efdmax=AVR_Data.Efdmax,
            Efdmin=AVR_Data.Efdmin,
            K_p=AVR_Data.K_p,
            K_i=AVR_Data.K_i,
            K_G=AVR_Data.K_G,
            K_M=AVR_Data.K_M,
            T_M=AVR_Data.T_M,
            V_Mmax=AVR_Data.V_Mmax,
            V_Mmin=AVR_Data.V_Mmin,
            X_L=AVR_Data.X_L,
            V_Gmax=AVR_Data.V_Gmax,
            th=AVR_Data.th,
            K_g=AVR_Data.K_G,
            V_Imax=AVR_Data.V_Imax,
            V_Imin=AVR_Data.V_Imax) constrainedby
            Components.Interfaces.Controller
            annotation (Placement(transformation(extent={{126,74},{172,94}})));
          replaceable Records.Controllers.AVR_AC1A AVR_Data(K_A=30, K_C=1.096)
            constrainedby Records.Base.AVR
            annotation (Placement(transformation(extent={{218,70},{238,90}})));
          Modelica.Electrical.MultiPhase.Basic.Star Neutral annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={80,-26})));
          Modelica.Electrical.Analog.Basic.Ground ground5
            annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
          Modelica.Electrical.MultiPhase.Basic.Resistor AC_Load(R=fill(5, 3))
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={80,-6})));
          Modelica.Blocks.Sources.TimeTable BallScrewSpeedCommands(table=[0.0,0;
                2,0; 2.01,80; 3,60; 4,-80; 6,0; 10,40; 11,-40; 12,0; 15,0; 15.1,
                60; 16,-60; 20,0; 21,0], timeScale=5) annotation (Placement(
                transformation(
                extent={{-13,-13},{13,13}},
                rotation=180,
                origin={201,-3})));
          Modelica.Blocks.Sources.TimeTable RPM(table=[0.0,0; 0.01,251; 0.5,361.8;
                1,251; 2,251; 3,251; 4.5,391.8; 6,0; 6,0.0; 10,0.0], timeScale=
                3600)         annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={56,82})));
        equation
          connect(RPM_Engine.y, RPMtoRPS.u)
            annotation (Line(points={{243,34},{218,34}}, color={0,0,127}));
          connect(generation.w_ref, RPMtoRPS.y)
            annotation (Line(points={{176,35},{194,35},{194,34},{195,34}},
                                                         color={0,0,127}));
          connect(Hydraulic_Pump.AC_in, generation.AC_out) annotation (Line(
                points={{74,35},{80,35},{80,35.26},{127.7,35.26}}, color={0,0,255}));
          connect(Fuel_Pump.AC_in, generation.AC_out) annotation (Line(points={{128,-2},
                  {98,-2},{98,35.26},{127.7,35.26}},     color={0,0,255}));
          connect(Ball_Screw_Actuator.AC_in, generation.AC_out) annotation (Line(
                points={{188,-38.5},{98,-38.5},{98,35.26},{127.7,35.26}}, color={
                  0,0,255}));
          connect(AVR.Measurement, generation.V) annotation (Line(points={{126,84},
                  {116,84},{116,49.3},{128.9,49.3}}, color={0,0,127}));
          connect(generation.Efd, AVR.Actuation) annotation (Line(points={{167.3,
                  46.7},{167.3,60},{180,60},{180,84},{168.714,84}}, color={0,0,
                  127}));
          connect(generation.Im, AVR.Aux_1) annotation (Line(points={{135.8,
                  49.3},{135.8,60.65},{135.857,60.65},{135.857,74}},
                                                               color={0,0,127}));
          connect(generation.Ifd, AVR.Aux_3) annotation (Line(points={{147.2,
                  49.3},{147.2,56},{160,56},{160,74},{156.667,74}},
                                                              color={0,0,127}));
          connect(generation.Ia, AVR.Aux_2) annotation (Line(points={{141.2,
                  49.3},{141.2,62},{145.933,62},{145.933,74}},
                                                         color={0,0,127}));
          connect(ground5.p, Neutral.pin_n)
            annotation (Line(points={{80,-40},{80,-36}}, color={0,0,255}));
          connect(Neutral.plug_p, AC_Load.plug_n)
            annotation (Line(points={{80,-16},{80,-16}}, color={0,0,255}));
          connect(AC_Load.plug_p, generation.AC_out) annotation (Line(points={{80,
                  4},{98,4},{98,35.26},{127.7,35.26}}, color={0,0,255}));
          connect(BallScrewSpeedCommands.y, Ball_Screw_Actuator.Ref) annotation (
              Line(points={{186.7,-3},{174,-3},{174,-32.35},{190.316,-32.35}},
                color={0,0,127}));
          connect(RPM.y, Hydraulic_Pump.w) annotation (Line(points={{56,71},{56,
                  60},{56,48},{50.4471,48}}, color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{40,-60},
                    {280,100}})),            Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{40,-60},{280,100}})),
            experiment(
              StopTime=200,
              Interval=0.001,
              __Dymola_fixedstepsize=0.001,
              __Dymola_Algorithm="Dassl"),
            __Dymola_experimentFlags(Advanced(
                InlineMethod=2,
                InlineOrder=2,
                InlineFixedStep=0.001)));
        end DistributionSystem_AC1;

        model DistributionSystem_DC1
          Modelica.Blocks.Sources.TimeTable RPM_Engine(table=[0.0,0; 0.001,11900;
                0.1,12000; 1,12000; 2,12000; 3,10000; 4.5,18000; 6,1; 6,0.0; 10,
                0.0], timeScale=3600) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={254,34})));
          Modelica.Blocks.Math.Gain RPMtoRPS(k=3.14/30) annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=180,
                origin={206,34})));
          replaceable Components.Generators.SynGenw    generation constrainedby
            Components.Interfaces.Generation                      annotation (
              Placement(transformation(
                extent={{-24,-13},{24,13}},
                rotation=0,
                origin={152,35})));
          replaceable Components.Load_Temp.Fuel_Pump
                                                  Fuel_Pump constrainedby
            Components.Interfaces.Loads
            annotation (Placement(transformation(extent={{128,-12},{148,8}})));
          replaceable Components.Load_Temp.PMSM Ball_Screw_Actuator(N=1/1.6)
            constrainedby Components.Interfaces.Loads
            annotation (Placement(transformation(extent={{188,-46},{232,-28}})));
          replaceable Components.Load_Temp.Induction_Motor Hydraulic_Pump(
            R_l=0,
            L_l=0,
            startTime=30) constrainedby Components.Interfaces.Loads annotation (
              Placement(transformation(
                extent={{-14,-13},{14,13}},
                rotation=180,
                origin={60,35})));
          replaceable Components.Generators.Controls.AVR_Type_DC1 AVR(
            Ref=1.02,
            T_R=AVR_Data.T_R,
            T_C=AVR_Data.T_C,
            T_B=AVR_Data.T_B,
            K_A=AVR_Data.K_A,
            T_A=AVR_Data.T_A,
            K_E=AVR_Data.K_E,
            T_E=AVR_Data.T_E,
            K_F=AVR_Data.K_F,
            T_F=AVR_Data.T_F,
            Vmax=AVR_Data.Vmax,
            Vmin=AVR_Data.Vmin,
            K_D=AVR_Data.K_D,
            K_C=AVR_Data.K_C,
            Efdmax=AVR_Data.Efdmax,
            Efdmin=AVR_Data.Efdmax,
            K_p=AVR_Data.K_p,
            K_i=AVR_Data.K_i,
            K_G=AVR_Data.K_G,
            K_M=AVR_Data.K_M,
            T_M=AVR_Data.T_M,
            V_Mmax=AVR_Data.V_Mmax,
            V_Mmin=AVR_Data.V_Mmin,
            X_L=AVR_Data.X_L,
            V_Gmax=AVR_Data.V_Gmax,
            th=AVR_Data.th,
            K_g=AVR_Data.K_G,
            V_Imax=AVR_Data.V_Imax,
            V_Imin=AVR_Data.V_Imax) constrainedby
            Components.Interfaces.Controller
            annotation (Placement(transformation(extent={{126,74},{172,94}})));
          replaceable Records.Controllers.TypeI_AVR AVR_Data constrainedby
            Records.Base.AVR
            annotation (Placement(transformation(extent={{218,70},{238,90}})));
          Modelica.Blocks.Sources.TimeTable RPM(table=[0.0,0; 0.001,251; 0.01,391;
                1,300; 2,300; 3,251; 4.5,391; 6,0; 6,0.0; 10,0.0],
              timeScale=3600) annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={50,84})));
          Modelica.Electrical.MultiPhase.Basic.Star Neutral annotation (Placement(
                transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={80,-26})));
          Modelica.Electrical.Analog.Basic.Ground GND
            annotation (Placement(transformation(extent={{70,-60},{90,-40}})));
          Modelica.Electrical.MultiPhase.Basic.Resistor AC_Load(R=fill(13.3, 3))
            annotation (Placement(transformation(
                extent={{-10,-10},{10,10}},
                rotation=270,
                origin={80,-6})));
          Modelica.Blocks.Sources.TimeTable BallScrewSpeedCommands(table=[0.0,0;
                2,0; 2.01,80; 3,60; 4,-80; 6,0; 10,40; 11,-40; 12,0; 15,0; 15.1,
                60; 16,-60; 20,0; 21,0], timeScale=5) annotation (Placement(
                transformation(
                extent={{-13,-13},{13,13}},
                rotation=180,
                origin={201,-3})));
        equation
          connect(RPM_Engine.y, RPMtoRPS.u)
            annotation (Line(points={{243,34},{218,34}}, color={0,0,127}));
          connect(generation.w_ref, RPMtoRPS.y)
            annotation (Line(points={{176,35},{194,35},{194,34},{195,34}},
                                                         color={0,0,127}));
          connect(Hydraulic_Pump.AC_in, generation.AC_out) annotation (Line(
                points={{74,35},{80,35},{80,35.26},{127.7,35.26}}, color={0,0,255}));
          connect(Fuel_Pump.AC_in, generation.AC_out) annotation (Line(points={{128,-2},
                  {98,-2},{98,35.26},{127.7,35.26}},     color={0,0,255}));
          connect(Ball_Screw_Actuator.AC_in, generation.AC_out) annotation (Line(
                points={{188,-38.5},{98,-38.5},{98,35.26},{127.7,35.26}}, color={
                  0,0,255}));
          connect(AVR.Measurement, generation.V) annotation (Line(points={{126,84},
                  {116,84},{116,49.3},{128.9,49.3}}, color={0,0,127}));
          connect(generation.Efd, AVR.Actuation) annotation (Line(points={{167.3,
                  46.7},{167.3,60},{180,60},{180,84},{173.211,84}}, color={0,0,
                  127}));
          connect(generation.Im, AVR.Aux_1) annotation (Line(points={{135.8,
                  49.3},{135.8,60.65},{136.895,60.65},{136.895,74}},
                                                               color={0,0,127}));
          connect(generation.Ifd, AVR.Aux_3) annotation (Line(points={{147.2,
                  49.3},{147.2,56},{160,56},{160,74},{159.895,74}},
                                                              color={0,0,127}));
          connect(generation.Ia, AVR.Aux_2) annotation (Line(points={{141.2,
                  49.3},{141.2,62},{148.032,62},{148.032,74}},
                                                         color={0,0,127}));
          connect(RPM.y, Hydraulic_Pump.w) annotation (Line(points={{50,73},{50,
                  48},{50.4471,48}},         color={0,0,127}));
          connect(GND.p, Neutral.pin_n)
            annotation (Line(points={{80,-40},{80,-36}}, color={0,0,255}));
          connect(Neutral.plug_p, AC_Load.plug_n)
            annotation (Line(points={{80,-16},{80,-16}}, color={0,0,255}));
          connect(AC_Load.plug_p, generation.AC_out) annotation (Line(points={{80,
                  4},{98,4},{98,35.26},{127.7,35.26}}, color={0,0,255}));
          connect(BallScrewSpeedCommands.y, Ball_Screw_Actuator.Ref) annotation (
              Line(points={{186.7,-3},{174,-3},{174,-32.35},{190.316,-32.35}},
                color={0,0,127}));
          annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{20,-60},
                    {280,100}})),            Diagram(coordinateSystem(
                  preserveAspectRatio=false, extent={{20,-60},{280,100}})),
            experiment(
              StopTime=200,
              Interval=0.001,
              Tolerance=1e-05,
              __Dymola_fixedstepsize=0.001,
              __Dymola_Algorithm="Dassl"),
            __Dymola_experimentFlags(
              Advanced(
                EvaluateAlsoTop=false,
                GenerateVariableDependencies=false,
                OutputModelicaCode=false),
              Evaluate=true,
              OutputCPUtime=false,
              OutputFlatModelica=false),
            __Dymola_experimentSetupOutput);
        end DistributionSystem_DC1;
      end Configurations;
    end Template;

  end Systems;

  package Interfaces
    model multiphtoabc
      Modelica.Electrical.MultiPhase.Interfaces.PositivePlug m
        annotation (Placement(transformation(extent={{-114,-10},{-94,10}}),
            iconTransformation(extent={{-114,-10},{-94,10}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin a
        annotation (Placement(transformation(extent={{94,86},{114,106}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin b
        annotation (Placement(transformation(extent={{94,-6},{114,14}})));
      Modelica.Electrical.Analog.Interfaces.PositivePin c
        annotation (Placement(transformation(extent={{94,-106},{114,-86}})));
    equation
      a.i = m.pin[1].i;
      a.v = m.pin[1].v;
      b.i = m.pin[2].i;
      b.v = m.pin[2].v;
      c.i = m.pin[3].i;
      c.v = m.pin[3].v;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Text(
              extent={{-88,122},{44,42}},
              lineColor={28,108,200},
              textString="3ph-abc"),
            Line(points={{2,46}}, color={238,46,47}),
            Line(
              points={{-98,2},{102,94}},
              color={255,0,0},
              thickness=1),
            Line(
              points={{-98,-2},{110,-100}},
              color={255,0,0},
              thickness=1),
            Line(
              points={{-94,0},{104,0}},
              color={255,0,0},
              thickness=1)}),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end multiphtoabc;
  end Interfaces;

  annotation (uses(Modelica(version="3.2.3")));
end AircraftPowerSystem;
