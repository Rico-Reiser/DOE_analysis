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
    // SHA1 = 941392ccbfd7ce52f0cec1a9f20379606f4caf20
    //
    // unique function name that can be checked if the correct library version
    // has been loaded
    void rampedInlet_941392ccbfd7ce52f0cec1a9f20379606f4caf20(bool load)
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
    rampedInletFixedValueFvPatchVectorField
);


const char* const rampedInletFixedValueFvPatchVectorField::SHA1sum =
    "941392ccbfd7ce52f0cec1a9f20379606f4caf20";


// * * * * * * * * * * * * * * * * Constructors  * * * * * * * * * * * * * * //

rampedInletFixedValueFvPatchVectorField::
rampedInletFixedValueFvPatchVectorField
(
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF
)
:
    fixedValueFvPatchField<vector>(p, iF)
{
    if (false)
    {
        Info<<"construct rampedInlet sha1: 941392ccbfd7ce52f0cec1a9f20379606f4caf20"
            " from patch/DimensionedField\n";
    }
}


rampedInletFixedValueFvPatchVectorField::
rampedInletFixedValueFvPatchVectorField
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
        Info<<"construct rampedInlet sha1: 941392ccbfd7ce52f0cec1a9f20379606f4caf20"
            " from patch/dictionary\n";
    }
}


rampedInletFixedValueFvPatchVectorField::
rampedInletFixedValueFvPatchVectorField
(
    const rampedInletFixedValueFvPatchVectorField& ptf,
    const fvPatch& p,
    const DimensionedField<vector, volMesh>& iF,
    const fvPatchFieldMapper& mapper
)
:
    fixedValueFvPatchField<vector>(ptf, p, iF, mapper)
{
    if (false)
    {
        Info<<"construct rampedInlet sha1: 941392ccbfd7ce52f0cec1a9f20379606f4caf20"
            " from patch/DimensionedField/mapper\n";
    }
}


rampedInletFixedValueFvPatchVectorField::
rampedInletFixedValueFvPatchVectorField
(
    const rampedInletFixedValueFvPatchVectorField& ptf,
    const DimensionedField<vector, volMesh>& iF
)
:
    fixedValueFvPatchField<vector>(ptf, iF)
{
    if (false)
    {
        Info<<"construct rampedInlet sha1: 941392ccbfd7ce52f0cec1a9f20379606f4caf20 "
            "as copy/DimensionedField\n";
    }
}


// * * * * * * * * * * * * * * * * Destructor  * * * * * * * * * * * * * * * //

rampedInletFixedValueFvPatchVectorField::
~rampedInletFixedValueFvPatchVectorField()
{
    if (false)
    {
        Info<<"destroy rampedInlet sha1: 941392ccbfd7ce52f0cec1a9f20379606f4caf20\n";
    }
}


// * * * * * * * * * * * * * * * Member Functions  * * * * * * * * * * * * * //

void rampedInletFixedValueFvPatchVectorField::updateCoeffs()
{
    if (this->updated())
    {
        return;
    }

    if (false)
    {
        Info<<"updateCoeffs rampedInlet sha1: 941392ccbfd7ce52f0cec1a9f20379606f4caf20\n";
    }

//{{{ begin code
    #line 56 "/home/rico-reiser/cases_OF10/new_cases/freezeWithflux/0/U/boundaryField/inlet"
const scalar t = this->db().time().value();

        const scalar Umax  = 0.1;
        const scalar tRamp = 0.002;

        scalar factor;

        if (t < tRamp)
        {
            factor = t/tRamp;
        }
        else
        {
            factor = 1.0;
        }

        this->operator==(vector(Umax*factor, 0, 0));
//}}} end code

    this->fixedValueFvPatchField<vector>::updateCoeffs();
}


// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * //

} // End namespace Foam

// ************************************************************************* //

