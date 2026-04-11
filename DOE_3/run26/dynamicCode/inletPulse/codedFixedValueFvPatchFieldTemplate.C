/*---------------------------------------------------------------------------*\
  =========                 |
  \\      /  F ield         | OpenFOAM: The Open Source CFD Toolbox
   \\    /   O peration     | Website:  https://openfoam.org
    \\  /    A nd           | Copyright (C) YEAR OpenFOAM Foundation
     \\/     M anipulation  |
-------------------------------------------------------------------------------
License
    This file is part of OpenFOAM.

    OpenFOAM is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    OpenFOAM is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
    FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
    for more details.

    You should have received a copy of the GNU General Public License
    along with OpenFOAM.  If not, see <http://www.gnu.org/licenses/>.

\*---------------------------------------------------------------------------*/

#include "codedFixedValueFvPatchFieldTemplate.H"
#include "addToRunTimeSelectionTable.H"
#include "fvPatchFieldMapper.H"
#include "volFields.H"
#include "surfaceFields.H"
#include "unitConversion.H"
//{{{ begin codeInclude

//}}} end codeInclude


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

namespace Foam
{

// * * * * * * * * * * * * * * * Local Functions * * * * * * * * * * * * * * //

//{{{ begin localCode

//}}} end localCode


// * * * * * * * * * * * * * * * Global Functions  * * * * * * * * * * * * * //

extern "C"
{
    // dynamicCode:
    // SHA1 = 689275963b59a9aa776624cb96a9e06bc2415f6d
    //
    // unique function name that can be checked if the correct library version
    // has been loaded
    void inletPulse_689275963b59a9aa776624cb96a9e06bc2415f6d(bool load)
    {
        if (load)
        {
            // code that can be explicitly executed after loading
        }
        else
        {
            // code that can be explicitly executed before unloading
        }
    }
}

// * * * * * * * * * * * * * * Static Data Members * * * * * * * * * * * * * //

makeRemovablePatchTypeField
(
    fvPatchVectorField,
    inletPulseFixedValueFvPatchVectorField
);


const char* const inletPulseFixedValueFvPatchVectorField::SHA1sum =
    "689275963b59a9aa776624cb96a9e06bc2415f6d";


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

inletPulseFixedValueFvPatchVectorField::
inletPulseFixedValueFvPatchVectorField
(
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF
)
:
    fixedValueFvPatchField<vector>(p, iF)
{
    if (false)
    {
        Info<<"construct inletPulse sha1: 689275963b59a9aa776624cb96a9e06bc2415f6d"
            " from patch/DimensionedField\n";
    }
}


inletPulseFixedValueFvPatchVectorField::
inletPulseFixedValueFvPatchVectorField
(
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF,
    const dictionary& dict
)
:
    fixedValueFvPatchField<vector>(p, iF, dict)
{
    if (false)
    {
        Info<<"construct inletPulse sha1: 689275963b59a9aa776624cb96a9e06bc2415f6d"
            " from patch/dictionary\n";
    }
}


inletPulseFixedValueFvPatchVectorField::
inletPulseFixedValueFvPatchVectorField
(
    const inletPulseFixedValueFvPatchVectorField& ptf,
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF,
    const fvPatchFieldMapper& mapper
)
:
    fixedValueFvPatchField<vector>(ptf, p, iF, mapper)
{
    if (false)
    {
        Info<<"construct inletPulse sha1: 689275963b59a9aa776624cb96a9e06bc2415f6d"
            " from patch/DimensionedField/mapper\n";
    }
}


inletPulseFixedValueFvPatchVectorField::
inletPulseFixedValueFvPatchVectorField
(
    const inletPulseFixedValueFvPatchVectorField& ptf,
    const DimensionedField<vector, volMesh>& iF
)
:
    fixedValueFvPatchField<vector>(ptf, iF)
{
    if (false)
    {
        Info<<"construct inletPulse sha1: 689275963b59a9aa776624cb96a9e06bc2415f6d "
            "as copy/DimensionedField\n";
    }
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

inletPulseFixedValueFvPatchVectorField::
~inletPulseFixedValueFvPatchVectorField()
{
    if (false)
    {
        Info<<"destroy inletPulse sha1: 689275963b59a9aa776624cb96a9e06bc2415f6d\n";
    }
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void inletPulseFixedValueFvPatchVectorField::updateCoeffs()
{
    if (this->updated())
    {
        return;
    }

    if (false)
    {
        Info<<"updateCoeffs inletPulse sha1: 689275963b59a9aa776624cb96a9e06bc2415f6d\n";
    }

//{{{ begin code
    #line 38 "/home/rico-reiser/cases_OF10/freezeAndFlux/case3/0/U/boundaryField/inlet"
const scalar t = this->db().time().value();
             if (t <= 1.25)
             {
                operator==(vector(0.01, 0, 0));
            }
            else
            {
                operator==(vector(0, 0, 0));
            }
//}}} end code

    this->fixedValueFvPatchField<vector>::updateCoeffs();
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************************************************************* //

